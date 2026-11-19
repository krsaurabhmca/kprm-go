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

type CaseListItem struct {
	ID             int
	ClientID       int
	ClientName     string
	StructureName  string
	ApplicantName  string
	ClientRefNo    string
	OverallStatus  string
	IsClosed       int
	TotalTasks     int
	CompletedTasks int
	TAT            string
	CreatedAt      string
}

// ListCases renders cases listing with filtering and pagination
func ListCases(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Manage Cases", "/cases")
	activeClientID, _ := data["ActiveClientID"].(int)

	search := strings.TrimSpace(c.Query("search"))
	statusFilter := strings.TrimSpace(c.Query("status"))
	pageStr := c.DefaultQuery("page", "1")
	page, _ := strconv.Atoi(pageStr)
	if page < 1 {
		page = 1
	}
	perPage := 20
	offset := (page - 1) * perPage

	db := database.GetDB()
	var cases []CaseListItem
	var totalCases int

	if db != nil {
		var whereClauses []string
		var args []interface{}

		if activeClientID > 0 {
			whereClauses = append(whereClauses, "cs.client_id = ?")
			args = append(args, activeClientID)
		}

		if statusFilter != "" {
			if strings.EqualFold(statusFilter, "Closed") {
				whereClauses = append(whereClauses, "c.is_closed = 1")
			} else {
				whereClauses = append(whereClauses, "c.status = ?")
				args = append(args, statusFilter)
			}
		}

		if search != "" {
			whereClauses = append(whereClauses, "(c.id = ? OR EXISTS (SELECT 1 FROM case_data cd WHERE cd.case_id = c.id AND cd.data_value LIKE ?))")
			caseIDSearch, _ := strconv.Atoi(search)
			args = append(args, caseIDSearch, "%"+search+"%")
		}

		whereSQL := ""
		if len(whereClauses) > 0 {
			whereSQL = " WHERE " + strings.Join(whereClauses, " AND ")
		}

		// Count total
		countQuery := "SELECT COUNT(*) FROM cases c LEFT JOIN client_structures cs ON c.structure_id = cs.id" + whereSQL
		_ = db.QueryRow(countQuery, args...).Scan(&totalCases)

		// Fetch page
		listQuery := fmt.Sprintf(`
			SELECT c.id, COALESCE(cs.client_id, 0), COALESCE(cl.name, 'Client') as client_name, COALESCE(cs.sheet_name, 'Format') as structure_name,
			       COALESCE(c.status, 'Pending') as status, c.is_closed, COALESCE(DATE_FORMAT(c.created_at, '%%d-%%b-%%Y'), '-'),
			       (SELECT COUNT(*) FROM case_tasks ct WHERE ct.case_id = c.id) as total_tasks,
			       (SELECT COUNT(*) FROM case_tasks ct WHERE ct.case_id = c.id AND ct.status IN ('Positive', 'Negative', 'CNV')) as completed_tasks,
			       COALESCE((SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = c.id AND (sc.excel_column_name LIKE '%%%%applicant%%%%' OR sc.excel_column_name LIKE '%%%%name%%%%') LIMIT 1), CONCAT('Case #', c.id)) as applicant_name,
			       COALESCE((SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = c.id AND (sc.excel_column_name LIKE '%%%%ref%%%%' OR sc.excel_column_name LIKE '%%%%loan%%%%' OR sc.excel_column_name LIKE '%%%%app%%%%no%%%%') LIMIT 1), '-') as client_ref_no
			FROM cases c
			LEFT JOIN client_structures cs ON c.structure_id = cs.id
			LEFT JOIN clients cl ON cs.client_id = cl.id
			%s
			ORDER BY c.id DESC
			LIMIT %d OFFSET %d
		`, whereSQL, perPage, offset)

		rows, err := db.Query(listQuery, args...)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var item CaseListItem
				var rawTime, appName, refNo, overallStat string
				_ = rows.Scan(
					&item.ID, &item.ClientID, &item.ClientName, &item.StructureName,
					&overallStat, &item.IsClosed, &rawTime,
					&item.TotalTasks, &item.CompletedTasks,
					&appName, &refNo,
				)
				item.OverallStatus = overallStat
				item.ApplicantName = appName
				item.ClientRefNo = refNo
				item.CreatedAt = utils.FormatDateString(rawTime, "02-Jan-2006 15:04")
				item.TAT = utils.CalculateTAT(rawTime, "")
				cases = append(cases, item)
			}
		}
	}

	totalPages := (totalCases + perPage - 1) / perPage
	if totalPages < 1 {
		totalPages = 1
	}

	data["Cases"] = cases
	data["Search"] = search
	data["StatusFilter"] = statusFilter
	data["CurrentPage"] = page
	data["TotalPages"] = totalPages
	data["TotalCases"] = totalCases

	c.HTML(http.StatusOK, "cases/list.html", data)
}

// ViewCase renders full case details, fields, tasks, attachments
func ViewCase(c *gin.Context) {
	caseIDStr := c.Param("id")
	if caseIDStr == "" {
		caseIDStr = c.Query("id")
	}
	caseID, _ := strconv.Atoi(caseIDStr)
	if caseID == 0 {
		c.Redirect(http.StatusFound, "/cases")
		return
	}

	db := database.GetDB()
	var kase models.Case
	var rawPickup, rawReverted, rawCreated sql.NullString

	q := `
		SELECT c.id, c.client_id, cl.name as client_name, c.structure_id, cs.structure_name,
		       c.overall_status, c.is_closed, c.pickup_date, c.reverted_date, c.created_at
		FROM cases c
		LEFT JOIN clients cl ON c.client_id = cl.id
		LEFT JOIN client_structures cs ON c.structure_id = cs.id
		WHERE c.id = ? LIMIT 1
	`
	err := db.QueryRow(q, caseID).Scan(
		&kase.ID, &kase.ClientID, &kase.ClientName, &kase.StructureID, &kase.StructureName,
		&kase.OverallStatus, &kase.IsClosed, &rawPickup, &rawReverted, &rawCreated,
	)
	if err != nil {
		c.Redirect(http.StatusFound, "/cases")
		return
	}

	// Fetch dynamic data columns
	dynamicData := make([]map[string]string, 0)
	cdRows, err := db.Query(`
		SELECT sc.display_name, sc.column_name, cd.data_value
		FROM case_data cd
		JOIN structure_columns sc ON cd.column_id = sc.id
		WHERE cd.case_id = ?
		ORDER BY sc.order_index ASC, sc.id ASC
	`, caseID)
	if err == nil {
		defer cdRows.Close()
		for cdRows.Next() {
			var dName, cName, dVal sql.NullString
			_ = cdRows.Scan(&dName, &cName, &dVal)
			dynamicData = append(dynamicData, map[string]string{
				"DisplayName": dName.String,
				"ColumnName":  cName.String,
				"Value":       dVal.String,
			})
		}
	}

	// Fetch tasks
	tasks := make([]map[string]interface{}, 0)
	tRows, err := db.Query(`
		SELECT ct.id, t.task_name, t.task_type, ct.status, ct.remarks, ct.verified_at,
		       COALESCE(u.username, 'Unassigned') as verifier_name
		FROM case_tasks ct
		JOIN tasks t ON ct.task_id = t.id
		LEFT JOIN users u ON ct.assigned_to = u.id
		WHERE ct.case_id = ?
		ORDER BY ct.id ASC
	`, caseID)
	if err == nil {
		defer tRows.Close()
		for tRows.Next() {
			var tid int
			var tName, tType, tStatus, tRemarks, tVerifier sql.NullString
			var rawVerified sql.NullTime
			_ = tRows.Scan(&tid, &tName, &tType, &tStatus, &tRemarks, &rawVerified, &tVerifier)

			vDate := "-"
			if rawVerified.Valid {
				vDate = rawVerified.Time.Format("02-Jan-2006 15:04")
			}

			tasks = append(tasks, map[string]interface{}{
				"ID":           tid,
				"TaskName":     tName.String,
				"TaskType":     tType.String,
				"Status":       tStatus.String,
				"StatusBadge":  utils.StatusBadgeHTML(tStatus.String),
				"Remarks":      tRemarks.String,
				"VerifierName": tVerifier.String,
				"VerifiedAt":   vDate,
			})
		}
	}

	data := middleware.GetBaseTemplateData(c, fmt.Sprintf("Case Details #%d", caseID), "/cases")
	data["Case"] = kase
	data["DynamicData"] = dynamicData
	data["Tasks"] = tasks
	data["CreatedAt"] = utils.FormatDateString(rawCreated.String, "02-Jan-2006 15:04")
	data["TAT"] = utils.CalculateTAT(rawCreated.String, rawReverted.String)

	c.HTML(http.StatusOK, "cases/view.html", data)
}

// CaseStageModalAPI returns stage lifecycle information for popup modal
func CaseStageModalAPI(c *gin.Context) {
	caseID, _ := strconv.Atoi(c.Param("id"))
	if caseID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid case ID"})
		return
	}

	db := database.GetDB()
	var kase models.Case
	err := db.QueryRow("SELECT c.id, cl.name as client_name, c.overall_status, c.is_closed FROM cases c LEFT JOIN clients cl ON c.client_id = cl.id WHERE c.id = ?", caseID).Scan(
		&kase.ID, &kase.ClientName, &kase.OverallStatus, &kase.IsClosed,
	)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Case not found"})
		return
	}

	// Fetch tasks
	type StageTask struct {
		ID             int    `json:"id"`
		TaskName       string `json:"task_name"`
		TaskType       string `json:"task_type"`
		Verifier       string `json:"verifier"`
		Status         string `json:"status"`
		StatusBadge    string `json:"status_badge"`
		Remarks        string `json:"remarks"`
		FinancialTable string `json:"financial_table,omitempty"`
	}

	var stageTasks []StageTask
	rows, err := db.Query(`
		SELECT ct.id, t.task_name, t.task_type, ct.status, ct.remarks,
		       COALESCE(u.username, 'Unassigned') as verifier_name
		FROM case_tasks ct
		JOIN tasks t ON ct.task_id = t.id
		LEFT JOIN users u ON ct.assigned_to = u.id
		WHERE ct.case_id = ?
		ORDER BY ct.id ASC
	`, caseID)

	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var st StageTask
			var rmk, tType sql.NullString
			_ = rows.Scan(&st.ID, &st.TaskName, &tType, &st.Status, &rmk, &st.Verifier)
			st.TaskType = tType.String
			st.Remarks = rmk.String
			st.StatusBadge = utils.StatusBadgeHTML(st.Status)

			// If financial task, generate comparison matrix table
			if strings.EqualFold(st.TaskType, "FINANCIAL") || strings.Contains(strings.ToLower(st.TaskName), "financial") {
				var finDataStr sql.NullString
				_ = db.QueryRow("SELECT data_value FROM case_task_data WHERE case_task_id = ? AND data_value LIKE '%section%' LIMIT 1", st.ID).Scan(&finDataStr)
				sections := utils.ParseFinancialData(finDataStr.String)
				st.FinancialTable = utils.RenderFinancialTableHTML(sections, false, "")
			}

			stageTasks = append(stageTasks, st)
		}
	}

	c.JSON(http.StatusOK, gin.H{
		"case_id":        kase.ID,
		"client_name":    kase.ClientName,
		"overall_status": kase.OverallStatus,
		"status_badge":   utils.StatusBadgeHTML(kase.OverallStatus),
		"tasks":          stageTasks,
	})
}

// ShowCaseSelect renders Step 1 for case creation
func ShowCaseSelect(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "New Case - Select Structure", "/cases/new")
	db := database.GetDB()

	var clients []models.Client
	cRows, _ := db.Query("SELECT id, name FROM clients ORDER BY name ASC")
	if cRows != nil {
		defer cRows.Close()
		for cRows.Next() {
			var cl models.Client
			_ = cRows.Scan(&cl.ID, &cl.Name)
			clients = append(clients, cl)
		}
	}

	var structures []models.ClientStructure
	sRows, _ := db.Query("SELECT id, client_id, structure_name FROM client_structures ORDER BY structure_name ASC")
	if sRows != nil {
		defer sRows.Close()
		for sRows.Next() {
			var cs models.ClientStructure
			_ = sRows.Scan(&cs.ID, &cs.ClientID, &cs.StructureName)
			structures = append(structures, cs)
		}
	}

	data["Clients"] = clients
	data["Structures"] = structures

	c.HTML(http.StatusOK, "cases/select.html", data)
}

// ShowCaseForm renders Step 2 dynamic form fields
func ShowCaseForm(c *gin.Context) {
	structureID, _ := strconv.Atoi(c.DefaultQuery("structure_id", c.PostForm("structure_id")))
	clientID, _ := strconv.Atoi(c.DefaultQuery("client_id", c.PostForm("client_id")))

	if structureID == 0 {
		c.Redirect(http.StatusFound, "/cases/new")
		return
	}

	db := database.GetDB()
	var sName string
	_ = db.QueryRow("SELECT structure_name FROM client_structures WHERE id = ?", structureID).Scan(&sName)

	var columns []models.StructureColumn
	rows, err := db.Query(`
		SELECT id, structure_id, column_name, display_name, data_type, is_mandatory, dropdown_options, calculated_formula, calculated_function, order_index
		FROM structure_columns
		WHERE structure_id = ?
		ORDER BY order_index ASC, id ASC
	`, structureID)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var col models.StructureColumn
			_ = rows.Scan(&col.ID, &col.StructureID, &col.ColumnName, &col.DisplayName, &col.DataType, &col.IsMandatory, &col.DropdownOptions, &col.CalculatedFormula, &col.CalculatedFunction, &col.OrderIndex)
			columns = append(columns, col)
		}
	}

	data := middleware.GetBaseTemplateData(c, fmt.Sprintf("Create Case: %s", sName), "/cases/new")
	data["StructureID"] = structureID
	data["ClientID"] = clientID
	data["StructureName"] = sName
	data["Columns"] = columns

	c.HTML(http.StatusOK, "cases/wizard.html", data)
}

// SaveCase creates new case and records dynamic column values
func SaveCase(c *gin.Context) {
	session := sessions.Default(c)
	structureID, _ := strconv.Atoi(c.PostForm("structure_id"))
	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	userID, _ := c.Get("user_id")
	createdByID, _ := userID.(int)

	if structureID == 0 || clientID == 0 {
		session.Set("error", "Invalid client or structure selected.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/cases/new")
		return
	}

	db := database.GetDB()
	res, err := db.Exec(`
		INSERT INTO cases (client_id, structure_id, created_by, overall_status, is_closed, created_at)
		VALUES (?, ?, ?, 'Pending', 0, NOW())
	`, clientID, structureID, createdByID)

	if err != nil {
		session.Set("error", "Error creating case: "+err.Error())
		_ = session.Save()
		c.Redirect(http.StatusFound, "/cases/new")
		return
	}

	newCaseID, _ := res.LastInsertId()

	// Insert all dynamic fields into case_data
	cRows, _ := db.Query("SELECT id, column_name FROM structure_columns WHERE structure_id = ?", structureID)
	if cRows != nil {
		defer cRows.Close()
		for cRows.Next() {
			var colID int
			var colName string
			_ = cRows.Scan(&colID, &colName)

			val := c.PostForm(fmt.Sprintf("col_%d", colID))
			if val == "" {
				val = c.PostForm(colName)
			}

			_, _ = db.Exec("INSERT INTO case_data (case_id, column_id, data_value) VALUES (?, ?, ?)", newCaseID, colID, val)
		}
	}

	session.Set("success", fmt.Sprintf("Case #%d created successfully!", newCaseID))
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/cases/view?id=%d", newCaseID))
}

// DeleteCase removes a case and its related records
func DeleteCase(c *gin.Context) {
	session := sessions.Default(c)
	caseID, _ := strconv.Atoi(c.Param("id"))
	if caseID == 0 {
		caseID, _ = strconv.Atoi(c.PostForm("case_id"))
	}

	db := database.GetDB()
	_, err := db.Exec("DELETE FROM cases WHERE id = ?", caseID)
	if err != nil {
		session.Set("error", "Error deleting case: "+err.Error())
	} else {
		session.Set("success", fmt.Sprintf("Case #%d deleted successfully.", caseID))
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/cases")
}

// CloseCase toggles case closed status
func CloseCase(c *gin.Context) {
	session := sessions.Default(c)
	caseID, _ := strconv.Atoi(c.Param("id"))
	if caseID == 0 {
		caseID, _ = strconv.Atoi(c.PostForm("case_id"))
	}

	db := database.GetDB()
	_, _ = db.Exec("UPDATE cases SET is_closed = 1, reverted_date = NOW() WHERE id = ?", caseID)
	session.Set("success", fmt.Sprintf("Case #%d has been marked as Closed.", caseID))
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/cases/view?id=%d", caseID))
}

