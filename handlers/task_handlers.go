package handlers

import (
	"database/sql"
	"fmt"
	"html/template"
	"net/http"
	"regexp"
	"strconv"
	"strings"

	"kprm2/database"
	"kprm2/middleware"
	"kprm2/models"
	"kprm2/utils"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
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

		// Fetch all blueprints for the 'Add Task to Case' modal
		var allBlueprints []models.Task
		bpRows, _ := db.Query("SELECT id, task_name, task_type FROM tasks ORDER BY task_type, task_name")
		if bpRows != nil {
			defer bpRows.Close()
			for bpRows.Next() {
				var bp models.Task
				_ = bpRows.Scan(&bp.ID, &bp.TaskName, &bp.TaskType)
				allBlueprints = append(allBlueprints, bp)
			}
		}
		data["AllBlueprints"] = allBlueprints

		// If caseIDFilter > 0, fetch case details for context banner
		if caseIDFilter > 0 {
			var cID int
			var sName, clName, cStatus string
			errC := db.QueryRow(`
				SELECT c.id, COALESCE(s.sheet_name, 'General'), COALESCE(cl.name, 'Client'), COALESCE(c.status, 'Pending')
				FROM cases c
				JOIN client_structures s ON c.structure_id = s.id
				JOIN clients cl ON s.client_id = cl.id
				WHERE c.id = ?
			`, caseIDFilter).Scan(&cID, &sName, &clName, &cStatus)
			if errC == nil {
				data["CaseDetails"] = map[string]interface{}{
					"ID":         cID,
					"SheetName":  sName,
					"ClientName": clName,
					"Status":     cStatus,
				}
			}
		}

		// Build task query
		var whereClauses []string
		var args []interface{}

		if activeClientID > 0 {
			whereClauses = append(whereClauses, "cs.client_id = ?")
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
			SELECT ct.id, ct.case_id, COALESCE(cl.name, 'Client') as client_name, t.task_name, t.task_type,
			       ct.assigned_to, COALESCE(u.username, 'Unassigned') as verifier_name,
			       COALESCE(ct.status, 'Pending') as task_status, COALESCE(ct.outcome, '') as outcome,
			       COALESCE(ct.final_remark, '') as final_remark, COALESCE(ct.remarks, '') as remarks,
			       COALESCE(DATE_FORMAT(ct.created_at, '%%%%d-%%%%b-%%%%Y'), '-'),
			       COALESCE(DATE_FORMAT(ct.verified_at, '%%%%d-%%%%b-%%%%Y %%%%H:%%%%i'), '-'),
			       COALESCE((SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = ct.case_id AND (sc.excel_column_name LIKE '%%%%%%%%applicant%%%%%%%%' OR sc.excel_column_name LIKE '%%%%%%%%name%%%%%%%%') LIMIT 1), CONCAT('Case #', ct.case_id)) as applicant_name
			FROM case_tasks ct
			JOIN tasks t ON ct.task_id = t.id
			JOIN cases c ON ct.case_id = c.id
			LEFT JOIN client_structures cs ON c.structure_id = cs.id
			LEFT JOIN clients cl ON cs.client_id = cl.id
			LEFT JOIN users u ON ct.assigned_to = u.id
			%s
			ORDER BY ct.id DESC LIMIT 100
		`, whereSQL)

		rows, err := db.Query(q, args...)
		if err != nil {
			// Resilient fallback without applicant_name subquery
			qFallback := `
				SELECT ct.id, ct.case_id, 'Client', t.task_name, t.task_type,
				       ct.assigned_to, COALESCE(u.username, 'Unassigned'),
				       COALESCE(ct.status, 'Pending'), COALESCE(ct.outcome, ''),
				       COALESCE(ct.final_remark, ''), COALESCE(ct.remarks, ''),
				       COALESCE(DATE_FORMAT(ct.created_at, '%d-%b-%Y'), '-'),
				       COALESCE(DATE_FORMAT(ct.verified_at, '%d-%b-%Y %H:%i'), '-'),
				       CONCAT('Case #', ct.case_id)
				FROM case_tasks ct
				JOIN tasks t ON ct.task_id = t.id
				LEFT JOIN users u ON ct.assigned_to = u.id
				ORDER BY ct.id DESC LIMIT 100
			`
			rows, err = db.Query(qFallback)
		}

		if err == nil && rows != nil {
			defer rows.Close()
			for rows.Next() {
				var tid, cid int
				var assignedTo sql.NullInt64
				var clName, tName, tType, vName, stat, outcome, fRem, rem, cDate, vDate, appName string

				_ = rows.Scan(&tid, &cid, &clName, &tName, &tType, &assignedTo, &vName, &stat, &outcome, &fRem, &rem, &cDate, &vDate, &appName)

				tasks = append(tasks, map[string]interface{}{
					"ID":            tid,
					"CaseID":        cid,
					"ClientName":    clName,
					"TaskName":      tName,
					"TaskType":      tType,
					"AssignedTo":    assignedTo.Int64,
					"VerifierName":  vName,
					"Status":        stat,
					"StatusBadge":   template.HTML(utils.StatusBadgeHTML(stat)),
					"Outcome":       outcome,
					"FinalRemark":   fRem,
					"Remarks":       rem,
					"ApplicantName": appName,
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
	if taskID == 0 {
		taskID, _ = strconv.Atoi(c.PostForm("id"))
	}
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
		SET assigned_to = ?, status = 'Assigned' 
		WHERE id = ?
	`, verifierID, taskID)

	if err != nil {
		session.Set("error", "Error assigning task: "+err.Error())
	} else {
		// Log to case_task_history if table exists
		userID, _ := c.Get("user_id")
		_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, 'Assigned', 'Assigned to verifier', ?)", taskID, userID)

		session.Set("success", fmt.Sprintf("Task #%d successfully assigned to verifier.", taskID))
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = "/tasks"
	}
	c.Redirect(http.StatusFound, referer)
}

// UpdateCaseTaskStatus updates status, outcome, and verification remarks for a task
func UpdateCaseTaskStatus(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("case_task_id"))
	if taskID == 0 {
		taskID, _ = strconv.Atoi(c.PostForm("id"))
	}
	newStatus := strings.TrimSpace(c.PostForm("new_status"))
	if newStatus == "" {
		newStatus = strings.TrimSpace(c.PostForm("status"))
	}
	outcome := strings.TrimSpace(c.PostForm("outcome"))
	finalRemark := strings.TrimSpace(c.PostForm("final_remark"))
	generalRemarks := strings.TrimSpace(c.PostForm("general_remarks"))
	if generalRemarks == "" {
		generalRemarks = strings.TrimSpace(c.PostForm("remarks"))
	}

	if taskID == 0 {
		session.Set("error", "Invalid task specified.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks")
		return
	}

	if newStatus == "" {
		newStatus = "Completed"
	}

	db := database.GetDB()
	if db != nil {
		_, err := db.Exec(`
			UPDATE case_tasks 
			SET status = ?, outcome = ?, final_remark = ?, remarks = ?,
			    verified_at = CASE WHEN ? IN ('Completed', 'Verified') THEN NOW() ELSE verified_at END
			WHERE id = ?
		`, newStatus, outcome, finalRemark, generalRemarks, newStatus, taskID)

		if err != nil {
			session.Set("error", "Failed to update task: "+err.Error())
		} else {
			userID, _ := c.Get("user_id")
			_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark, created_by) VALUES (?, ?, ?, ?)", taskID, newStatus, finalRemark, userID)
			session.Set("success", fmt.Sprintf("Task #%d status updated to '%s' (Outcome: %s).", taskID, newStatus, outcome))
		}
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = "/tasks"
	}
	c.Redirect(http.StatusFound, referer)
}

// AddCaseTask creates a new case task blueprint instance for a case
func AddCaseTask(c *gin.Context) {
	session := sessions.Default(c)
	caseID, _ := strconv.Atoi(c.PostForm("case_id"))
	taskID, _ := strconv.Atoi(c.PostForm("task_id"))
	assignedTo, _ := strconv.Atoi(c.PostForm("assigned_to"))

	if caseID == 0 || taskID == 0 {
		session.Set("error", "Both Case ID and Blueprint Task are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks")
		return
	}

	db := database.GetDB()
	if db != nil {
		userID, _ := c.Get("user_id")
		status := "Pending"
		var assignedVal interface{} = nil
		if assignedTo > 0 {
			assignedVal = assignedTo
			status = "Assigned"
		}

		res, err := db.Exec(`
			INSERT INTO case_tasks (case_id, task_id, status, assigned_to, created_by)
			VALUES (?, ?, ?, ?, ?)
		`, caseID, taskID, status, assignedVal, userID)

		if err != nil {
			session.Set("error", "Failed to add task: "+err.Error())
		} else {
			newID, _ := res.LastInsertId()
			session.Set("success", fmt.Sprintf("Task #%d added to Case #%d successfully.", newID, caseID))
		}
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = fmt.Sprintf("/tasks?case_id=%d", caseID)
	}
	c.Redirect(http.StatusFound, referer)
}

// DeleteCaseTask deletes an assigned task from a case
func DeleteCaseTask(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.PostForm("case_task_id"))
	if taskID == 0 {
		taskID, _ = strconv.Atoi(c.PostForm("id"))
	}

	if taskID == 0 {
		session.Set("error", "Invalid task to delete.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks")
		return
	}

	db := database.GetDB()
	if db != nil {
		_, _ = db.Exec("DELETE FROM case_task_data WHERE case_task_id = ?", taskID)
		_, _ = db.Exec("DELETE FROM case_task_history WHERE case_task_id = ?", taskID)
		_, err := db.Exec("DELETE FROM case_tasks WHERE id = ?", taskID)
		if err != nil {
			session.Set("error", "Failed to delete task: "+err.Error())
		} else {
			session.Set("success", fmt.Sprintf("Task #%d assignment removed.", taskID))
		}
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = "/tasks"
	}
	c.Redirect(http.StatusFound, referer)
}

// HandleLegacyCaseTasksPost routes legacy POST /case_tasks.php actions
func HandleLegacyCaseTasksPost(c *gin.Context) {
	action := c.PostForm("action")
	switch action {
	case "add_case_task":
		AddCaseTask(c)
	case "assign_verifier":
		AssignTask(c)
	case "delete_case_task":
		DeleteCaseTask(c)
	case "change_task_status", "submit_review":
		UpdateCaseTaskStatus(c)
	default:
		c.Redirect(http.StatusFound, "/tasks")
	}
}

// ManageTasks displays and configures master blueprints
func ManageTasks(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Task Blueprints", "/tasks/blueprints")
	db := database.GetDB()

	type TaskBlueprintItem struct {
		ID         int
		TaskName   string
		TaskType   string
		FieldCount int
		CreatedAt  string
	}

	var blueprints []TaskBlueprintItem
	if db != nil {
		q := `
			SELECT t.id, t.task_name, t.task_type,
			       COALESCE((SELECT COUNT(*) FROM task_meta tm WHERE tm.task_id = t.id), 0) as field_count,
			       COALESCE(DATE_FORMAT(t.created_at, '%d-%b-%Y'), '')
			FROM tasks t
			ORDER BY t.id ASC
		`
		rows, err := db.Query(q)
		if err != nil {
			// Resilient fallback
			rows, err = db.Query("SELECT t.id, t.task_name, t.task_type, 0, COALESCE(DATE_FORMAT(t.created_at, '%d-%b-%Y'), '') FROM tasks t ORDER BY t.id ASC")
		}
		if err == nil && rows != nil {
			defer rows.Close()
			for rows.Next() {
				var b TaskBlueprintItem
				var rawCreated sql.NullString
				var fCount sql.NullInt64
				_ = rows.Scan(&b.ID, &b.TaskName, &b.TaskType, &fCount, &rawCreated)
				b.FieldCount = int(fCount.Int64)
				b.CreatedAt = rawCreated.String
				blueprints = append(blueprints, b)
			}
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
	taskID, _ := strconv.Atoi(c.PostForm("task_id"))

	if taskName == "" || taskType == "" {
		session.Set("error", "Task name and type are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/tasks/blueprints")
		return
	}

	db := database.GetDB()
	if taskID > 0 {
		_, err := db.Exec("UPDATE tasks SET task_name = ?, task_type = ? WHERE id = ?", taskName, taskType, taskID)
		if err != nil {
			session.Set("error", "Error updating task: "+err.Error())
		} else {
			session.Set("success", "Task template updated successfully.")
		}
	} else {
		_, err := db.Exec("INSERT INTO tasks (task_name, task_type, created_at) VALUES (?, ?, NOW())", taskName, taskType)
		if err != nil {
			session.Set("error", "Error creating task: "+err.Error())
		} else {
			session.Set("success", "Task template created successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/tasks/blueprints")
}

// ManageTaskMeta handles task meta field definitions, RBAC, and standard remarks
func ManageTaskMeta(c *gin.Context) {
	taskIDStr := c.Query("task_id")
	if taskIDStr == "" {
		taskIDStr = c.Query("id")
	}
	taskID, _ := strconv.Atoi(taskIDStr)
	if taskID == 0 {
		c.Redirect(http.StatusFound, "/tasks/blueprints")
		return
	}

	data := middleware.GetBaseTemplateData(c, "Task Meta Management", "/tasks/blueprints")
	db := database.GetDB()

	// Fetch current task
	var task models.Task
	err := db.QueryRow("SELECT id, task_name, task_type FROM tasks WHERE id = ?", taskID).Scan(&task.ID, &task.TaskName, &task.TaskType)
	if err != nil {
		c.Redirect(http.StatusFound, "/tasks/blueprints")
		return
	}

	// Fetch user roles
	var roles []models.UserRole
	rRows, _ := db.Query("SELECT id, role_name FROM user_roles ORDER BY id ASC")
	if rRows != nil {
		defer rRows.Close()
		for rRows.Next() {
			var r models.UserRole
			_ = rRows.Scan(&r.ID, &r.RoleName)
			roles = append(roles, r)
		}
	}

	// Fetch meta fields
	var metaFields []models.TaskMeta
	mRows, err := db.Query(`
		SELECT id, task_id, COALESCE(variable_tag, ''), field_name, data_type, is_mandatory, show_in_details, COALESCE(list_options, ''), send_in_message
		FROM task_meta
		WHERE task_id = ?
		ORDER BY id ASC
	`, taskID)
	if err == nil && mRows != nil {
		defer mRows.Close()
		for mRows.Next() {
			var m models.TaskMeta
			var vTag, lOpt string
			_ = mRows.Scan(&m.ID, &m.TaskID, &vTag, &m.FieldName, &m.DataType, &m.IsMandatory, &m.ShowInDetails, &lOpt, &m.SendInMessage)
			m.VariableTag = sql.NullString{String: vTag, Valid: true}
			m.ListOptions = sql.NullString{String: lOpt, Valid: true}
			m.DisplayName = m.FieldName
			m.MetaKey = vTag

			// Fetch RBAC for this meta field
			m.RBAC = make(map[int]string)
			rbacRows, _ := db.Query("SELECT role_id, access_level FROM task_meta_rbac WHERE task_meta_id = ?", m.ID)
			if rbacRows != nil {
				for rbacRows.Next() {
					var rID int
					var acc string
					_ = rbacRows.Scan(&rID, &acc)
					m.RBAC[rID] = acc
				}
				rbacRows.Close()
			}
			metaFields = append(metaFields, m)
		}
	}

	// Fetch task remarks
	var remarks []models.TaskRemarks
	remRows, _ := db.Query("SELECT id, task_id, remark_type, remark_text FROM task_remarks WHERE task_id = ? ORDER BY remark_type ASC, id ASC", taskID)
	if remRows != nil {
		defer remRows.Close()
		for remRows.Next() {
			var r models.TaskRemarks
			_ = remRows.Scan(&r.ID, &r.TaskID, &r.RemarkType, &r.RemarkText)
			r.Status = r.RemarkType
			r.RemarkTemplate = r.RemarkText
			remarks = append(remarks, r)
		}
	}

	data["Task"] = task
	data["TaskID"] = taskID
	data["Roles"] = roles
	data["MetaFields"] = metaFields
	data["Remarks"] = remarks

	c.HTML(http.StatusOK, "tasks/meta.html", data)
}

// SaveTaskMetaField creates or updates a meta field and its role RBAC
func SaveTaskMetaField(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.DefaultPostForm("task_id", c.Query("id")))
	metaID, _ := strconv.Atoi(c.PostForm("meta_id"))
	fieldName := strings.TrimSpace(c.PostForm("field_name"))
	dataType := strings.TrimSpace(c.PostForm("data_type"))
	variableTag := strings.TrimSpace(c.PostForm("variable_tag"))
	if variableTag != "" && !strings.HasPrefix(variableTag, "#") {
		variableTag = "#" + variableTag
	}
	if variableTag != "" && !strings.HasSuffix(variableTag, "#") {
		variableTag = variableTag + "#"
	}

	isMandatory := 0
	if c.PostForm("is_mandatory") != "" {
		isMandatory = 1
	}
	showInDetails := 0
	if c.PostForm("show_in_details") != "" {
		showInDetails = 1
	}
	sendInMessage := 0
	if c.PostForm("send_in_message") != "" {
		sendInMessage = 1
	}
	listOptions := strings.TrimSpace(c.PostForm("list_options"))

	if taskID == 0 || fieldName == "" || dataType == "" {
		session.Set("error", "Task ID, field name, and data type are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
		return
	}

	db := database.GetDB()

	// Query roles for RBAC
	var roleIDs []int
	rRows, _ := db.Query("SELECT id, role_name FROM user_roles ORDER BY id ASC")
	if rRows != nil {
		for rRows.Next() {
			var rid int
			var rname string
			_ = rRows.Scan(&rid, &rname)
			roleIDs = append(roleIDs, rid)
		}
		rRows.Close()
	}

	if metaID > 0 {
		_, err := db.Exec(`
			UPDATE task_meta
			SET field_name = ?, data_type = ?, variable_tag = ?, is_mandatory = ?, show_in_details = ?, send_in_message = ?, list_options = ?
			WHERE id = ? AND task_id = ?
		`, fieldName, dataType, variableTag, isMandatory, showInDetails, sendInMessage, listOptions, metaID, taskID)
		if err != nil {
			session.Set("error", "Error updating field: "+err.Error())
		} else {
			// Update RBAC
			for _, rid := range roleIDs {
				acc := c.PostForm(fmt.Sprintf("rbac_%d", rid))
				if acc == "" {
					acc = "Write"
				}
				_, _ = db.Exec(`
					INSERT INTO task_meta_rbac (task_meta_id, role_id, access_level)
					VALUES (?, ?, ?)
					ON DUPLICATE KEY UPDATE access_level = VALUES(access_level)
				`, metaID, rid, acc)
			}
			session.Set("success", "Field updated successfully.")
		}
	} else {
		res, err := db.Exec(`
			INSERT INTO task_meta (task_id, field_name, data_type, variable_tag, is_mandatory, show_in_details, send_in_message, list_options)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)
		`, taskID, fieldName, dataType, variableTag, isMandatory, showInDetails, sendInMessage, listOptions)
		if err != nil {
			session.Set("error", "Error adding field: "+err.Error())
		} else {
			newID, _ := res.LastInsertId()
			for _, rid := range roleIDs {
				acc := c.PostForm(fmt.Sprintf("rbac_%d", rid))
				if acc == "" {
					acc = "Write"
				}
				_, _ = db.Exec("INSERT INTO task_meta_rbac (task_meta_id, role_id, access_level) VALUES (?, ?, ?)", newID, rid, acc)
			}
			session.Set("success", "Field added successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// DeleteTaskMetaField removes a meta field
func DeleteTaskMetaField(c *gin.Context) {
	session := sessions.Default(c)
	taskID, _ := strconv.Atoi(c.DefaultPostForm("task_id", c.Query("task_id")))
	metaID, _ := strconv.Atoi(c.DefaultPostForm("meta_id", c.Param("id")))

	db := database.GetDB()
	_, err := db.Exec("DELETE FROM task_meta WHERE id = ? AND task_id = ?", metaID, taskID)
	if err != nil {
		session.Set("error", "Error deleting field: "+err.Error())
	} else {
		session.Set("success", "Field removed successfully.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// ToggleTaskMetaFlag toggles show_in_details or send_in_message
func ToggleTaskMetaFlag(c *gin.Context) {
	taskID, _ := strconv.Atoi(c.DefaultQuery("task_id", c.PostForm("task_id")))
	metaID, _ := strconv.Atoi(c.DefaultQuery("meta_id", c.PostForm("meta_id")))
	flag := c.DefaultQuery("flag", c.PostForm("flag"))

	db := database.GetDB()
	if flag == "show_in_details" {
		_, _ = db.Exec("UPDATE task_meta SET show_in_details = IF(show_in_details=1, 0, 1) WHERE id = ? AND task_id = ?", metaID, taskID)
	} else if flag == "send_in_message" {
		_, _ = db.Exec("UPDATE task_meta SET send_in_message = IF(send_in_message=1, 0, 1) WHERE id = ? AND task_id = ?", metaID, taskID)
	}
	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// SaveTaskRemark creates or updates a standard verification remark template and auto-extracts #tags#
func SaveTaskRemark(c *gin.Context) {
	session := sessions.Default(c)
	taskIDStr := c.PostForm("task_id")
	if taskIDStr == "" {
		taskIDStr = c.Query("task_id")
	}
	if taskIDStr == "" {
		taskIDStr = c.Query("id")
	}
	taskID, _ := strconv.Atoi(taskIDStr)

	remarkID, _ := strconv.Atoi(c.PostForm("remark_id"))
	remarkType := strings.TrimSpace(c.PostForm("remark_type"))
	remarkText := strings.TrimSpace(c.PostForm("remark_text"))

	if taskID == 0 || remarkType == "" || remarkText == "" {
		session.Set("error", "Outcome and remark text are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
		return
	}

	db := database.GetDB()
	var err error
	if remarkID > 0 {
		_, err = db.Exec("UPDATE task_remarks SET remark_type = ?, remark_text = ? WHERE id = ? AND task_id = ?", remarkType, remarkText, remarkID, taskID)
	} else {
		_, err = db.Exec("INSERT INTO task_remarks (task_id, remark_type, remark_text) VALUES (?, ?, ?)", taskID, remarkType, remarkText)
	}

	if err != nil {
		session.Set("error", "Failed to save remark template: "+err.Error())
		_ = session.Save()
		c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
		return
	}

	// Auto-extract #tags# and create fields in task_meta if not already present
	re := regexp.MustCompile(`#([a-zA-Z0-9_]+)#`)
	matches := re.FindAllString(remarkText, -1)
	if len(matches) > 0 {
		// Get roles
		var roles []int
		rRows, _ := db.Query("SELECT id FROM user_roles")
		if rRows != nil {
			for rRows.Next() {
				var rid int
				_ = rRows.Scan(&rid)
				roles = append(roles, rid)
			}
			rRows.Close()
		}

		for _, tag := range matches {
			cleanTag := tag
			raw := strings.Trim(tag, "#")
			fieldName := strings.Title(strings.ReplaceAll(raw, "_", " "))

			var count int
			_ = db.QueryRow("SELECT COUNT(*) FROM task_meta WHERE task_id = ? AND (variable_tag = ? OR field_name = ? OR field_name = ?)", taskID, cleanTag, raw, fieldName).Scan(&count)
			if count == 0 {
				res, errM := db.Exec("INSERT INTO task_meta (task_id, field_name, data_type, variable_tag, is_mandatory, show_in_details, send_in_message) VALUES (?, ?, 'Text', ?, 0, 0, 1)", taskID, fieldName, cleanTag)
				if errM == nil {
					newMID, _ := res.LastInsertId()
					for _, rid := range roles {
						_, _ = db.Exec("INSERT INTO task_meta_rbac (task_meta_id, role_id, access_level) VALUES (?, ?, 'Write')", newMID, rid)
					}
				}
			}
		}
	}

	session.Set("success", "Remark template saved successfully. Any new #tags# have been auto-created as input fields.")
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// DeleteTaskRemark deletes a standard remark template
func DeleteTaskRemark(c *gin.Context) {
	session := sessions.Default(c)
	taskIDStr := c.PostForm("task_id")
	if taskIDStr == "" {
		taskIDStr = c.Query("task_id")
	}
	if taskIDStr == "" {
		taskIDStr = c.Query("id")
	}
	taskID, _ := strconv.Atoi(taskIDStr)
	remarkID, _ := strconv.Atoi(c.DefaultPostForm("remark_id", c.Param("id")))

	db := database.GetDB()
	_, _ = db.Exec("DELETE FROM task_remarks WHERE id = ? AND task_id = ?", remarkID, taskID)
	session.Set("success", "Remark template deleted.")
	_ = session.Save()

	c.Redirect(http.StatusFound, fmt.Sprintf("/tasks/meta?task_id=%d", taskID))
}

// HandleTaskMetaPost routes legacy or direct POST /manage_task_meta.php based on action
func HandleTaskMetaPost(c *gin.Context) {
	action := c.PostForm("action")
	switch action {
	case "add_remark", "edit_remark":
		SaveTaskRemark(c)
	case "delete_remark":
		DeleteTaskRemark(c)
	case "delete_meta":
		DeleteTaskMetaField(c)
	case "toggle_field":
		ToggleTaskMetaFlag(c)
	default:
		SaveTaskMetaField(c)
	}
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
