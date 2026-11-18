package handlers

import (
	"database/sql"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/utils"
)

// ListReviewTasks displays review queue for quality reviewers & admins
func ListReviewTasks(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Review Verification Queue", "/review")
	activeClientID, _ := data["ActiveClientID"].(int)

	statusFilter := strings.TrimSpace(c.DefaultQuery("status", "Review Pending"))
	search := strings.TrimSpace(c.Query("search"))

	db := database.GetDB()
	var tasks []map[string]interface{}

	if db != nil {
		var whereClauses []string
		var args []interface{}

		if activeClientID > 0 {
			whereClauses = append(whereClauses, "c.client_id = ?")
			args = append(args, activeClientID)
		}

		if statusFilter != "ALL" && statusFilter != "" {
			whereClauses = append(whereClauses, "ct.status = ?")
			args = append(args, statusFilter)
		}

		if search != "" {
			whereClauses = append(whereClauses, "(ct.id = ? OR t.task_name LIKE ? OR c.id = ?)")
			sID, _ := strconv.Atoi(search)
			args = append(args, sID, "%"+search+"%", sID)
		}

		whereSQL := ""
		if len(whereClauses) > 0 {
			whereSQL = " WHERE " + strings.Join(whereClauses, " AND ")
		}

		q := fmt.Sprintf(`
			SELECT ct.id, ct.case_id, cl.name as client_name, t.task_name, t.task_type,
			       COALESCE(u.username, 'Unassigned') as verifier_name,
			       ct.status, ct.remarks, ct.verified_at,
			       (SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = ct.case_id AND (sc.column_name LIKE '%%applicant%%' OR sc.column_name LIKE '%%name%%') LIMIT 1) as applicant_name
			FROM case_tasks ct
			JOIN tasks t ON ct.task_id = t.id
			JOIN cases c ON ct.case_id = c.id
			LEFT JOIN clients cl ON c.client_id = cl.id
			LEFT JOIN users u ON ct.assigned_to = u.id
			%s
			ORDER BY ct.id DESC LIMIT 100
		`, whereSQL)

		rows, err := db.Query(q, args...)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var tid, cid int
				var clName, tName, tType, vName, stat, rem, appName sql.NullString
				var rawVerified sql.NullTime

				_ = rows.Scan(&tid, &cid, &clName, &tName, &tType, &vName, &stat, &rem, &rawVerified, &appName)

				vDate := "-"
				if rawVerified.Valid {
					vDate = rawVerified.Time.Format("02-Jan-2006 15:04")
				}

				tasks = append(tasks, map[string]interface{}{
					"ID":            tid,
					"CaseID":        cid,
					"ClientName":    clName.String,
					"TaskName":      tName.String,
					"TaskType":      tType.String,
					"VerifierName":  vName.String,
					"Status":        stat.String,
					"StatusBadge":   utils.StatusBadgeHTML(stat.String),
					"Remarks":       rem.String,
					"ApplicantName": appName.String,
					"VerifiedAt":    vDate,
				})
			}
		}
	}

	data["Tasks"] = tasks
	data["StatusFilter"] = statusFilter
	data["Search"] = search

	c.HTML(http.StatusOK, "review/list.html", data)
}

// SubmitReviewDecision finalizes the verification outcome and updates parent case status
func SubmitReviewDecision(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("case_task_id"))
	decision := strings.TrimSpace(c.PostForm("decision")) // 'Positive', 'Negative', 'CNV', 'Reassign'
	remarks := strings.TrimSpace(c.PostForm("remarks"))
	userID, _ := c.Get("user_id")
	currentUserID, _ := userID.(int)

	if taskID == 0 || decision == "" {
		session.Set("error", "Task ID and Decision Outcome are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/review")
		return
	}

	db := database.GetDB()

	var caseID int
	_ = db.QueryRow("SELECT case_id FROM case_tasks WHERE id = ?", taskID).Scan(&caseID)

	if decision == "Reassign" {
		_, _ = db.Exec("UPDATE case_tasks SET status = 'In Progress', remarks = ? WHERE id = ?", remarks, taskID)
		_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, 'In Progress', ?, ?)", taskID, "Reassigned back to verifier: "+remarks, currentUserID)
		session.Set("success", fmt.Sprintf("Task #%d has been sent back to verifier.", taskID))
	} else {
		_, _ = db.Exec("UPDATE case_tasks SET status = ?, remarks = ? WHERE id = ?", decision, remarks, taskID)
		_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, ?, ?, ?)", taskID, decision, remarks, currentUserID)

		// Recalculate parent case overall status
		if caseID > 0 {
			rows, err := db.Query("SELECT status FROM case_tasks WHERE case_id = ?", caseID)
			if err == nil {
				defer rows.Close()
				var caseTasksList []struct{ Status, Outcome string }
				for rows.Next() {
					var s string
					_ = rows.Scan(&s)
					caseTasksList = append(caseTasksList, struct{ Status, Outcome string }{Status: s, Outcome: s})
				}
				overallStatus := utils.ComputeOverallStatus(caseTasksList)
				_, _ = db.Exec("UPDATE cases SET overall_status = ? WHERE id = ?", overallStatus, caseID)
			}
		}

		session.Set("success", fmt.Sprintf("Task #%d reviewed successfully as %s.", taskID, decision))
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/review")
}

