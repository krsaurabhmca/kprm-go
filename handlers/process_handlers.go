package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/utils"
)

// ListProcessTasks displays tasks queue for field verifiers
func ListProcessTasks(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Field Verification Tasks", "/process")
	userID, _ := c.Get("user_id")
	userRole, _ := c.Get("role_name")
	roleStr, _ := userRole.(string)
	currentUserID, _ := userID.(int)

	statusFilter := strings.TrimSpace(c.DefaultQuery("status", "In Progress"))
	search := strings.TrimSpace(c.Query("search"))

	db := database.GetDB()
	var tasks []map[string]interface{}

	if db != nil {
		var whereClauses []string
		var args []interface{}

		// Non-admin/dev only sees their assigned tasks
		if !strings.EqualFold(roleStr, "Admin") && !strings.EqualFold(roleStr, "DEV") {
			whereClauses = append(whereClauses, "ct.assigned_to = ?")
			args = append(args, currentUserID)
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
			       ct.status, ct.remarks, ct.created_at,
			       (SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = ct.case_id AND (sc.column_name LIKE '%%applicant%%' OR sc.column_name LIKE '%%name%%') LIMIT 1) as applicant_name
			FROM case_tasks ct
			JOIN tasks t ON ct.task_id = t.id
			JOIN cases c ON ct.case_id = c.id
			LEFT JOIN clients cl ON c.client_id = cl.id
			%s
			ORDER BY ct.id DESC LIMIT 100
		`, whereSQL)

		rows, err := db.Query(q, args...)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var tid, cid int
				var clName, tName, tType, stat, rem, appName sql.NullString
				var rawCreated sql.NullTime

				_ = rows.Scan(&tid, &cid, &clName, &tName, &tType, &stat, &rem, &rawCreated, &appName)

				cDate := "-"
				if rawCreated.Valid {
					cDate = rawCreated.Time.Format("02-Jan-2006 15:04")
				}

				tasks = append(tasks, map[string]interface{}{
					"ID":            tid,
					"CaseID":        cid,
					"ClientName":    clName.String,
					"TaskName":      tName.String,
					"TaskType":      tType.String,
					"Status":        stat.String,
					"StatusBadge":   utils.StatusBadgeHTML(stat.String),
					"Remarks":       rem.String,
					"ApplicantName": appName.String,
					"CreatedAt":     cDate,
				})
			}
		}
	}

	data["Tasks"] = tasks
	data["StatusFilter"] = statusFilter
	data["Search"] = search

	c.HTML(http.StatusOK, "process/list.html", data)
}

// SubmitProcessTask processes verifier data submission
func SubmitProcessTask(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("case_task_id"))
	userID, _ := c.Get("user_id")
	currentUserID, _ := userID.(int)

	if taskID == 0 {
		session.Set("error", "Invalid task ID.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/process")
		return
	}

	db := database.GetDB()

	// 1. Save Meta Form Data
	metaKeys := c.Request.PostForm
	for k, vals := range metaKeys {
		if strings.HasPrefix(k, "meta_") {
			metaIDStr := strings.TrimPrefix(k, "meta_")
			metaID, _ := strconv.Atoi(metaIDStr)
			if metaID > 0 && len(vals) > 0 {
				val := vals[0]
				_, _ = db.Exec(`
					INSERT INTO case_task_data (case_task_id, task_meta_id, data_value)
					VALUES (?, ?, ?)
					ON DUPLICATE KEY UPDATE data_value = VALUES(data_value)
				`, taskID, metaID, val)
			}
		}
	}

	// 2. Handle File Uploads
	form, err := c.MultipartForm()
	if err == nil && form != nil {
		uploadDir := filepath.Join(config.AppConfig.UploadPath, "tasks")
		_ = os.MkdirAll(uploadDir, 0755)

		files := form.File["attachments"]
		for _, file := range files {
			timestamp := time.Now().Unix()
			filename := fmt.Sprintf("%d_%s", timestamp, filepath.Base(file.Filename))
			dst := filepath.Join(uploadDir, filename)
			if err := c.SaveUploadedFile(file, dst); err == nil {
				// Save attachment reference
				_, _ = db.Exec(`
					INSERT INTO case_task_data (case_task_id, task_meta_id, data_value)
					SELECT ?, id, ? FROM task_meta WHERE (data_type = 'file' OR meta_key LIKE '%attachment%') LIMIT 1
				`, taskID, filename)
			}
		}
	}

	// 3. Handle Financial Grid Data if submitted
	finProv := c.PostFormMap("fin_provided")
	finRec := c.PostFormMap("fin_records")
	if len(finProv) > 0 || len(finRec) > 0 {
		sections := utils.ParseFinancialData("")
		for sIdx := range sections {
			for iIdx := range sections[sIdx].Items {
				key := fmt.Sprintf("%d_%d", sIdx, iIdx)
				if pStr, ok := finProv[key]; ok {
					pVal, _ := strconv.ParseFloat(pStr, 64)
					sections[sIdx].Items[iIdx].Provided = pVal
				}
				if rStr, ok := finRec[key]; ok {
					rVal, _ := strconv.ParseFloat(rStr, 64)
					sections[sIdx].Items[iIdx].Records = rVal
				}
			}
		}
		finJSON, _ := json.Marshal(sections)
		_, _ = db.Exec(`
			INSERT INTO case_task_data (case_task_id, task_meta_id, data_value)
			SELECT ?, id, ? FROM task_meta WHERE (data_type = 'Financial_Table' OR data_type = 'financial_grid') LIMIT 1
		`, taskID, string(finJSON))
	}

	// 4. Update task status to 'Review Pending'
	_, _ = db.Exec(`
		UPDATE case_tasks 
		SET status = 'Review Pending', verified_at = NOW() 
		WHERE id = ?
	`, taskID)

	// 5. Record history
	_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, 'Review Pending', 'Field verification completed and submitted for review', ?)", taskID, currentUserID)

	session.Set("success", fmt.Sprintf("Task #%d successfully verified and submitted to review queue.", taskID))
	_ = session.Save()
	c.Redirect(http.StatusFound, "/process")
}
