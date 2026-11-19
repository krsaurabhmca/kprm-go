package handlers

import (
	"database/sql"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/models"
	"kprm2/utils"
)

// ManageReports displays reports hub and templates list
func ManageReports(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Manage Report Templates", "/reports")
	db := database.GetDB()

	type ReportTemplateItem struct {
		ID         int
		Name       string
		SheetName  string
		ClientName string
		CreatedAt  string
	}

	type ClientReportItem struct {
		ID            int
		Name          string
		CaseCount     int
		PositiveCount int
		PendingCount  int
	}

	var templates []ReportTemplateItem
	var clients []ClientReportItem

	if db != nil {
		// Fetch report templates
		qTpl := `
			SELECT r.id, r.name, COALESCE(r.sheet_name, 'Sheet1'),
			       COALESCE(c.name, 'Unassigned') as client_name,
			       COALESCE(DATE_FORMAT(r.created_at, '%d-%b-%Y'), '-') as created_at
			FROM report_templates r
			LEFT JOIN clients c ON r.client_id = c.id
			ORDER BY r.created_at DESC
		`
		tRows, errT := db.Query(qTpl)
		if errT == nil {
			defer tRows.Close()
			for tRows.Next() {
				var tItem ReportTemplateItem
				_ = tRows.Scan(&tItem.ID, &tItem.Name, &tItem.SheetName, &tItem.ClientName, &tItem.CreatedAt)
				templates = append(templates, tItem)
			}
		}

		// Fetch client metrics
		q := `
			SELECT cl.id, cl.name,
			       COUNT(DISTINCT ca.id) as case_count,
			       COALESCE(SUM(CASE WHEN ca.status = 'Positive' THEN 1 ELSE 0 END), 0) as positive_count,
			       COALESCE(SUM(CASE WHEN ca.status NOT IN ('Positive', 'Completed', 'CNV') THEN 1 ELSE 0 END), 0) as pending_count
			FROM clients cl
			LEFT JOIN client_structures cs ON cl.id = cs.client_id
			LEFT JOIN cases ca ON cs.id = ca.structure_id
			GROUP BY cl.id, cl.name
			ORDER BY cl.name ASC
		`
		rows, err := db.Query(q)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var item ClientReportItem
				_ = rows.Scan(&item.ID, &item.Name, &item.CaseCount, &item.PositiveCount, &item.PendingCount)
				clients = append(clients, item)
			}
		}
	}

	data["Templates"] = templates
	data["Clients"] = clients
	c.HTML(http.StatusOK, "reports/list.html", data)
}

// GenerateReport generates HTML view, PDF print preview, or Excel MIS export
func GenerateReport(c *gin.Context) {
	caseID, _ := strconv.Atoi(c.DefaultQuery("case_id", c.Query("id")))
	exportType := strings.ToLower(c.DefaultQuery("type", "html"))

	if caseID == 0 {
		c.Redirect(http.StatusFound, "/reports")
		return
	}

	db := database.GetDB()
	var kase models.Case
	var createdStr string
	q := `
		SELECT c.id, COALESCE(cs.client_id, 0), COALESCE(cl.name, 'Client'), c.structure_id, COALESCE(cs.sheet_name, 'Standard'),
		       COALESCE(c.status, 'Pending'), c.is_closed, COALESCE(DATE_FORMAT(c.created_at, '%d-%b-%Y'), '')
		FROM cases c
		LEFT JOIN client_structures cs ON c.structure_id = cs.id
		LEFT JOIN clients cl ON cs.client_id = cl.id
		WHERE c.id = ? LIMIT 1
	`
	err := db.QueryRow(q, caseID).Scan(
		&kase.ID, &kase.ClientID, &kase.ClientName, &kase.StructureID, &kase.StructureName,
		&kase.OverallStatus, &kase.IsClosed, &createdStr,
	)
	if err != nil {
		c.String(http.StatusNotFound, "Case not found.")
		return
	}

	// Fetch dynamic case fields
	caseFields := make(map[string]string)
	cdRows, err := db.Query(`
		SELECT COALESCE(sc.excel_column_name, ''), COALESCE(cd.data_value, '')
		FROM case_data cd
		JOIN structure_columns sc ON cd.column_id = sc.id
		WHERE cd.case_id = ?
		ORDER BY sc.id ASC
	`, caseID)
	if err == nil {
		defer cdRows.Close()
		for cdRows.Next() {
			var colName, dVal string
			_ = cdRows.Scan(&colName, &dVal)
			if colName != "" {
				caseFields[colName] = dVal
			}
		}
	}

	// Fetch tasks
	tasks := make([]map[string]string, 0)
	var financialHTML string
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
				vDate = rawVerified.Time.Format("02-Jan-2006")
			}

			tasks = append(tasks, map[string]string{
				"task_name":   tName.String,
				"status":      tStatus.String,
				"remarks":     tRemarks.String,
				"verifier":    tVerifier.String,
				"verified_at": vDate,
			})

			// Check for financial statement table
			if strings.EqualFold(tType.String, "FINANCIAL") || strings.Contains(strings.ToLower(tName.String), "financial") {
				var finDataStr sql.NullString
				_ = db.QueryRow("SELECT data_value FROM case_task_data WHERE case_task_id = ? AND data_value LIKE '%section%' LIMIT 1", tid).Scan(&finDataStr)
				sections := utils.ParseFinancialData(finDataStr.String)
				financialHTML = utils.RenderFinancialTableHTML(sections, false, "")
			}
		}
	}

	// If Excel export requested
	if exportType == "excel" || exportType == "xlsx" || c.Query("export") == "mis" {
		c.Header("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
		c.Header("Content-Disposition", fmt.Sprintf("attachment; filename=KPRM2_Report_Case_%d.xlsx", caseID))

		headers := []string{"Case ID", "Client", "Structure", "Parameter", "Verification Detail", "Status", "TAT"}
		rows := make([][]string, 0)
		for k, v := range caseFields {
			rows = append(rows, []string{
				strconv.Itoa(caseID),
				kase.ClientName,
				kase.StructureName,
				k,
				v,
				kase.OverallStatus,
				"-",
			})
		}
		for _, t := range tasks {
			rows = append(rows, []string{
				strconv.Itoa(caseID),
				kase.ClientName,
				kase.StructureName,
				t["task_name"],
				t["remarks"],
				t["status"],
				"-",
			})
		}

		_ = utils.GenerateExcelReport("MIS Verification", headers, rows, c.Writer)
		return
	}

	// HTML / Print View
	data := middleware.GetBaseTemplateData(c, fmt.Sprintf("Verification Report #%d", caseID), "/reports")
	data["Case"] = kase
	data["CaseFields"] = caseFields
	data["TasksTableHTML"] = utils.FormatTaskRemarksTable(tasks, []string{"sr_no", "task_name", "verifier", "verified_at", "status", "remarks"})
	data["FinancialTableHTML"] = financialHTML
	data["CreatedAt"] = createdStr
	data["TAT"] = "-"

	c.HTML(http.StatusOK, "reports/preview.html", data)
}

