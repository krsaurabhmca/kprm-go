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
	"kprm2/models"
	"kprm2/utils"
)

// ListTasks handles operational task overview and assignment screen
func ListTasks(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Case Tasks Management", "/tasks")
	activeClientID, _ := data["ActiveClientID"].(int)

	caseIDFilter, _ := strconv.Atoi(c.Query("case_id"))
	statusFilter := strings.TrimSpace(c.Query("status"))
	search := strings.TrimSpace(c.Query("search"))

	db := database.GetDB()
	var tasks []map[string]interface{}
	var verifiers []models.User

	if db != nil {
		// Fetch verifiers list for assignment dropdown
		vRows, _ := db.Query("SELECT u.id, u.username FROM users u JOIN user_roles r ON u.role_id = r.id WHERE r.role_name = 'Verifier' ORDER BY u.username ASC")
		if vRows != nil {
			defer vRows.Close()
			for vRows.Next() {
				var v models.User
				_ = vRows.Scan(&v.ID, &v.Username)
				verifiers = append(verifiers, v)
			}
		}

		// Build task query
		var whereClauses []string
		var args []interface{}

		if activeClientID > 0 {
			whereClauses = append(whereClauses, "c.client_id = ?")
			args = append(args, activeClientID)
		}
		if caseIDFilter > 0 {
			whereClauses = append(whereClauses, "ct.case_id = ?")
			args = append(args, caseIDFilter)
		}
		if statusFilter != "" {
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
			       ct.assigned_to, COALESCE(u.username, 'Unassigned') as verifier_name,
			       ct.status, ct.remarks, ct.created_at, ct.verified_at,
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
				var assignedTo sql.NullInt64
				var clName, tName, tType, vName, stat, rem, appName sql.NullString
				var rawCreated, rawVerified sql.NullTime

				_ = rows.Scan(&tid, &cid, &clName, &tName, &tType, &assignedTo, &vName, &stat, &rem, &rawCreated, &rawVerified, &appName)

				vDate := "-"
				if rawVerified.Valid {
					vDate = rawVerified.Time.Format("02-Jan-2006 15:04")
				}
				cDate := "-"
				if rawCreated.Valid {
					cDate = rawCreated.Time.Format("02-Jan-2006")
				}

				tasks = append(tasks, map[string]interface{}{
					"ID":            tid,
					"CaseID":        cid,
					"ClientName":    clName.String,
					"TaskName":      tName.String,
					"TaskType":      tType.String,
					"AssignedTo":    assignedTo.Int64,
					"VerifierName":  vName.String,
					"Status":        stat.String,
					"StatusBadge":   utils.StatusBadgeHTML(stat.String),
					"Remarks":       rem.String,
					"ApplicantName": appName.String,
					"CreatedAt":     cDate,
					"VerifiedAt":    vDate,
				})
			}
		}
	}

	data["Tasks"] = tasks
	data["Verifiers"] = verifiers
	data["CaseIDFilter"] = caseIDFilter
	data["StatusFilter"] = statusFilter
	data["Search"] = search

	c.HTML(http.StatusOK, "tasks/list.html", data)
}

// AssignTask handles assigning a task to a verifier
func AssignTask(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("case_task_id"))
	verifierID, _ := strconv.Atoi(c.PostForm("assigned_to"))

	if taskID == 0 || verifierID == 0 {
		session.Set("error", "Invalid task or verifier selected.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks")
		return
	}

	db := database.GetDB()
	_, err := db.Exec(`
		UPDATE case_tasks 
		SET assigned_to = ?, status = 'In Progress' 
		WHERE id = ?
	`, verifierID, taskID)

	if err != nil {
		session.Set("error", "Error assigning task: "+err.Error())
	} else {
		// Log to case_task_history
		userID, _ := c.Get("user_id")
		_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, 'In Progress', 'Assigned to verifier', ?)", taskID, userID)

		session.Set("success", fmt.Sprintf("Task #%d assigned successfully to verifier.", taskID))
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = "/tasks"
	}
	c.Redirect(http.StatusFound, referer)
}

// ManageTasks displays and configures master blueprints
func ManageTasks(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Task Blueprints", "/tasks/blueprints")
	db := database.GetDB()

	var blueprints []models.Task
	rows, err := db.Query("SELECT id, task_name, task_type, COALESCE(description, ''), created_at FROM tasks ORDER BY id DESC")
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var t models.Task
			var desc string
			_ = rows.Scan(&t.ID, &t.TaskName, &t.TaskType, &desc, &t.CreatedAt)
			t.Description = sql.NullString{String: desc, Valid: true}
			blueprints = append(blueprints, t)
		}
	}

	data["Blueprints"] = blueprints
	c.HTML(http.StatusOK, "tasks/blueprints.html", data)
}

// SaveTaskBlueprint creates or updates a master task template
func SaveTaskBlueprint(c *gin.Context) {
	session := sessions.Default(c)
	taskName := strings.TrimSpace(c.PostForm("task_name"))
	taskType := strings.ToUpper(strings.TrimSpace(c.PostForm("task_type")))
	desc := strings.TrimSpace(c.PostForm("description"))
	taskID, _ := strconv.Atoi(c.PostForm("task_id"))

	if taskName == "" || taskType == "" {
		session.Set("error", "Task name and type are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks/blueprints")
		return
	}

	db := database.GetDB()
	if taskID > 0 {
		_, err := db.Exec("UPDATE tasks SET task_name = ?, task_type = ?, description = ? WHERE id = ?", taskName, taskType, desc, taskID)
		if err != nil {
			session.Set("error", "Error updating task: "+err.Error())
		} else {
			session.Set("success", "Task template updated successfully.")
		}
	} else {
		_, err := db.Exec("INSERT INTO tasks (task_name, task_type, description, created_at) VALUES (?, ?, ?, NOW())", taskName, taskType, desc)
		if err != nil {
			session.Set("error", "Error creating task: "+err.Error())
		} else {
			session.Set("success", "New task template created successfully.")
		}
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/tasks/blueprints")
}

// ManageTaskMeta handles task meta field definitions and RBAC
func ManageTaskMeta(c *gin.Context) {
	taskID, _ := strconv.Atoi(c.Query("task_id"))
	data := middleware.GetBaseTemplateData(c, "Task Meta Management", "/tasks/meta")
	db := database.GetDB()

	var tasks []models.Task
	tRows, _ := db.Query("SELECT id, task_name, task_type FROM tasks ORDER BY task_name ASC")
	if tRows != nil {
		defer tRows.Close()
		for tRows.Next() {
			var t models.Task
			_ = tRows.Scan(&t.ID, &t.TaskName, &t.TaskType)
			tasks = append(tasks, t)
		}
	}

	var metaFields []models.TaskMeta
	if taskID > 0 {
		mRows, _ := db.Query("SELECT id, task_id, meta_key, display_name, data_type, is_required, options, order_index FROM task_meta WHERE task_id = ? ORDER BY order_index ASC, id ASC", taskID)
		if mRows != nil {
			defer mRows.Close()
			for mRows.Next() {
				var m models.TaskMeta
				_ = mRows.Scan(&m.ID, &m.TaskID, &m.MetaKey, &m.DisplayName, &m.DataType, &m.IsRequired, &m.Options, &m.OrderIndex)
				metaFields = append(metaFields, m)
			}
		}
	}

	data["Tasks"] = tasks
	data["SelectedTaskID"] = taskID
	data["MetaFields"] = metaFields

	c.HTML(http.StatusOK, "tasks/meta.html", data)
}

// SaveTaskMeta handles adding/updating a task meta field
func SaveTaskMeta(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("task_id"))
	metaKey := strings.TrimSpace(c.PostForm("meta_key"))
	displayName := strings.TrimSpace(c.PostForm("display_name"))
	dataType := strings.TrimSpace(c.PostForm("data_type"))
	isRequired, _ := strconv.Atoi(c.PostForm("is_required"))
	options := strings.TrimSpace(c.PostForm("options"))

	if taskID == 0 || metaKey == "" || displayName == "" {
		session.Set("error", "Task ID, Meta Key, and Display Name are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
		return
	}

	db := database.GetDB()
	_, err := db.Exec(`
		INSERT INTO task_meta (task_id, meta_key, display_name, data_type, is_required, options)
		VALUES (?, ?, ?, ?, ?, ?)
	`, taskID, metaKey, displayName, dataType, isRequired, options)

	if err != nil {
		session.Set("error", "Error saving meta field: "+err.Error())
	} else {
		session.Set("success", "Meta field added successfully.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// ManageTaskFormats lists task report format configurations
func ManageTaskFormats(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Task Report Formats", "/tasks/formats")
	db := database.GetDB()

	var formats []models.TaskReportFormat
	rows, err := db.Query("SELECT id, name, slug, description, columns_json, options_json, is_system FROM task_report_formats ORDER BY id ASC")
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var f models.TaskReportFormat
			_ = rows.Scan(&f.ID, &f.Name, &f.Slug, &f.Description, &f.ColumnsJSON, &f.OptionsJSON, &f.IsSystem)
			formats = append(formats, f)
		}
	}

	data["Formats"] = formats
	c.HTML(http.StatusOK, "tasks/formats.html", data)
}

