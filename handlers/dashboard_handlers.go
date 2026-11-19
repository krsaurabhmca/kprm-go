package handlers

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
)

type DashboardKPI struct {
	TotalCases      int
	PendingTasks    int
	CompletedTasks  int
	ReviewQueue     int
	ClosedCases     int
	PositiveCases   int
	NegativeCases   int
	CNVCases        int
	PendingOutcomes int
}

type DashboardCaseItem struct {
	ID            int
	ClientName    string
	StructureName string
	ApplicantName string
	OverallStatus string
	IsClosed      int
	CreatedAt     string
	TAT           string
	TaskCount     int
}

// ShowDashboard renders main dashboard
func ShowDashboard(c *gin.Context) {
	roleName, _ := c.Get("role_name")
	roleStr, _ := roleName.(string)

	// If verifier or reviewer, redirect to their dedicated operational screens
	if strings.EqualFold(roleStr, "Verifier") {
		c.Redirect(http.StatusFound, "/process")
		return
	} else if strings.EqualFold(roleStr, "Reviewer") {
		c.Redirect(http.StatusFound, "/review")
		return
	}

	data := middleware.GetBaseTemplateData(c, "Dashboard", "/")
	activeClientID, _ := data["ActiveClientID"].(int)

	db := database.GetDB()
	var kpi DashboardKPI

	if db != nil {
		// Calculate KPIs with client filter if active
		clientCaseWhere := ""
		clientTaskWhere := ""
		if activeClientID > 0 {
			clientCaseWhere = fmt.Sprintf(" JOIN client_structures cs ON cases.structure_id = cs.id WHERE cs.client_id = %d", activeClientID)
			clientTaskWhere = fmt.Sprintf(" JOIN cases c ON ct.case_id = c.id JOIN client_structures cs ON c.structure_id = cs.id WHERE cs.client_id = %d", activeClientID)
		}

		// Total cases & closed cases
		_ = db.QueryRow("SELECT COUNT(*), COALESCE(SUM(CASE WHEN cases.is_closed = 1 THEN 1 ELSE 0 END), 0) FROM cases" + clientCaseWhere).Scan(&kpi.TotalCases, &kpi.ClosedCases)

		// Status breakdown
		posWhere := " WHERE status = 'Positive'"
		negWhere := " WHERE status = 'Negative'"
		cnvWhere := " WHERE status = 'CNV'"
		penWhere := " WHERE status NOT IN ('Positive', 'Negative', 'CNV') OR status IS NULL"
		if activeClientID > 0 {
			posWhere = fmt.Sprintf(" JOIN client_structures cs ON cases.structure_id = cs.id WHERE cases.status = 'Positive' AND cs.client_id = %d", activeClientID)
			negWhere = fmt.Sprintf(" JOIN client_structures cs ON cases.structure_id = cs.id WHERE cases.status = 'Negative' AND cs.client_id = %d", activeClientID)
			cnvWhere = fmt.Sprintf(" JOIN client_structures cs ON cases.structure_id = cs.id WHERE cases.status = 'CNV' AND cs.client_id = %d", activeClientID)
			penWhere = fmt.Sprintf(" JOIN client_structures cs ON cases.structure_id = cs.id WHERE (cases.status NOT IN ('Positive', 'Negative', 'CNV') OR cases.status IS NULL) AND cs.client_id = %d", activeClientID)
		}
		_ = db.QueryRow("SELECT COUNT(*) FROM cases" + posWhere).Scan(&kpi.PositiveCases)
		_ = db.QueryRow("SELECT COUNT(*) FROM cases" + negWhere).Scan(&kpi.NegativeCases)
		_ = db.QueryRow("SELECT COUNT(*) FROM cases" + cnvWhere).Scan(&kpi.CNVCases)
		_ = db.QueryRow("SELECT COUNT(*) FROM cases" + penWhere).Scan(&kpi.PendingOutcomes)

		// Tasks stats
		taskQuery := "SELECT " +
			"COALESCE(SUM(CASE WHEN ct.status IN ('Pending', 'In Progress') THEN 1 ELSE 0 END), 0), " +
			"COALESCE(SUM(CASE WHEN ct.status = 'Review Pending' THEN 1 ELSE 0 END), 0), " +
			"COALESCE(SUM(CASE WHEN ct.status IN ('Positive', 'Negative', 'CNV') THEN 1 ELSE 0 END), 0) " +
			"FROM case_tasks ct"
		if clientTaskWhere != "" {
			taskQuery += clientTaskWhere
		}
		_ = db.QueryRow(taskQuery).Scan(&kpi.PendingTasks, &kpi.ReviewQueue, &kpi.CompletedTasks)
	}

	// Fetch recent 10 cases
	var recentCases []DashboardCaseItem
	if db != nil {
		q := `
			SELECT c.id, COALESCE(cl.name, 'Client') as client_name, COALESCE(cs.sheet_name, 'Format') as structure_name,
			       COALESCE(c.status, 'Pending'), c.is_closed, COALESCE(DATE_FORMAT(c.created_at, '%%d-%%b-%%Y'), '-'),
			       (SELECT COUNT(*) FROM case_tasks ct WHERE ct.case_id = c.id) as task_count,
			       COALESCE((SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
			        WHERE cd.case_id = c.id AND (sc.excel_column_name LIKE '%%%%applicant%%%%' OR sc.excel_column_name LIKE '%%%%name%%%%') LIMIT 1), CONCAT('Case #', c.id)) as applicant_name
			FROM cases c
			LEFT JOIN client_structures cs ON c.structure_id = cs.id
			LEFT JOIN clients cl ON cs.client_id = cl.id
		`
		if activeClientID > 0 {
			q += fmt.Sprintf(" WHERE cs.client_id = %d", activeClientID)
		}
		q += " ORDER BY c.id DESC LIMIT 10"

		rows, err := db.Query(q)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var item DashboardCaseItem
				_ = rows.Scan(&item.ID, &item.ClientName, &item.StructureName, &item.OverallStatus, &item.IsClosed, &item.CreatedAt, &item.TaskCount, &item.ApplicantName)
				item.TAT = "-"
				recentCases = append(recentCases, item)
			}
		}
	}

	data["KPI"] = kpi
	data["RecentCases"] = recentCases

	c.HTML(http.StatusOK, "dashboard.html", data)
}

