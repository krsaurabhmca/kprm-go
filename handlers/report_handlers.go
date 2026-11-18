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
	data := middleware.GetBaseTemplateData(c, "Report Center & MIS", "/reports")
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
	var rawCreated, rawReverted sql.NullString
	q := `
		SELECT c.id, c.client_id, cl.name as client_name, c.structure_id, cs.structure_name,
		       c.overall_status, c.is_closed, c.created_at, c.reverted_date
		FROM cases c
		LEFT JOIN clients cl ON c.client_id = cl.id
		LEFT JOIN client_structures cs ON c.structure_id = cs.id
		WHERE c.id = ? LIMIT 1
	`
	err := db.QueryRow(q, caseID).Scan(
		&kase.ID, &kase.ClientID, &kase.ClientName, &kase.StructureID, &kase.StructureName,
		&kase.OverallStatus, &kase.IsClosed, &rawCreated, &rawReverted,
	)
	if err != nil {
		c.String(http.StatusNotFound, "Case not found.")
		return
	}

	// Fetch dynamic case fields
	caseFields := make(map[string]string)
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
			caseFields[dName.String] = dVal.String
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
				utils.CalculateTAT(rawCreated.String, rawReverted.String),
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
	data["CreatedAt"] = utils.FormatDateString(rawCreated.String, "02-Jan-2006 15:04")
	data["TAT"] = utils.CalculateTAT(rawCreated.String, rawReverted.String)

	c.HTML(http.StatusOK, "reports/preview.html", data)
}

