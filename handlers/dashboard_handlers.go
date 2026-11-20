package handlers

import (
	"database/sql"
	"fmt"
	"net/http"
	"strings"
	"time"

	"kprm2/database"
	"kprm2/middleware"

	"github.com/gin-gonic/gin"
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

type PeriodInfo struct {
	Key   string
	Label string
	Badge string
	Short string
}

type PeriodKPI struct {
	Cases          int
	TasksCreated   int
	TasksVerified  int
	TasksCompleted int
	Positive       int
	Negative       int
	PendingQueue   int
}

type TaskStatRow struct {
	TaskID          int
	TaskName        string
	TaskType        string
	TotalAllTime    int
	PendingCount    int
	PeriodCreated   int
	PeriodVerified  int
	PeriodCompleted int
	PeriodPositive  int
	PeriodNegative  int
}

type ClientStatRow struct {
	ClientID             int
	ClientName           string
	TotalStructures      int
	TotalCases           int
	PeriodCases          int
	TotalTasks           int
	PeriodTasksCreated   int
	PeriodTasksVerified  int
	PeriodTasksCompleted int
	PendingQueue         int
}

type StructureStatRow struct {
	StructureID          int
	SheetName            string
	TotalCases           int
	PeriodCases          int
	TotalTasks           int
	PeriodTasksCreated   int
	PeriodTasksVerified  int
	PeriodTasksCompleted int
	PendingQueue         int
}

type GlobalSummary struct {
	TotalClients    int
	TotalStructures int
	TotalCases      int
	TotalTasks      int
	TotalUsers      int
	TotalPending    int
}

type VerifierDashboardData struct {
	PendingTasks  int
	VerifiedTasks int
}

type ReviewerDashboardData struct {
	TasksToReview  int
	CompletedTasks int
}

func getDateSqlCondition(col, period string) string {
	switch period {
	case "today":
		return fmt.Sprintf("DATE(%s) = CURDATE()", col)
	case "week":
		return fmt.Sprintf("YEARWEEK(%s, 1) = YEARWEEK(CURDATE(), 1)", col)
	case "month":
		return fmt.Sprintf("YEAR(%s) = YEAR(CURDATE()) AND MONTH(%s) = MONTH(CURDATE())", col, col)
	case "year":
		return fmt.Sprintf("YEAR(%s) = YEAR(CURDATE())", col)
	default:
		return "1=1"
	}
}

// ShowDashboard renders main dashboard matching PHP index.php
func ShowDashboard(c *gin.Context) {
	roleName, _ := c.Get("role_name")
	roleStr, _ := roleName.(string)
	userName, _ := c.Get("username")
	userStr, _ := userName.(string)
	userIDVal, _ := c.Get("user_id")
	userID, _ := userIDVal.(int)

	data := middleware.GetBaseTemplateData(c, "Dashboard", "/")
	activeClientID, _ := data["ActiveClientID"].(int)

	// Greeting calculation
	hour := time.Now().Hour()
	greeting := "Good Morning"
	if hour >= 12 && hour < 17 {
		greeting = "Good Afternoon"
	} else if hour >= 17 {
		greeting = "Good Evening"
	}
	data["Greeting"] = greeting
	data["FormattedDate"] = time.Now().Format("Monday, January 2, 2006")
	data["DisplayUsername"] = strings.Title(userStr)

	db := database.GetDB()
	if db == nil {
		c.HTML(http.StatusOK, "dashboard.html", data)
		return
	}

	// 1. Verifier Dashboard
	if strings.EqualFold(roleStr, "Verifier") {
		var vData VerifierDashboardData
		clientFilter := ""
		if activeClientID > 0 {
			clientFilter = fmt.Sprintf(" AND ct.case_id IN (SELECT id FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = %d))", activeClientID)
		}
		_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE assigned_to = %d AND status IN ('Pending', 'Assigned') %s", userID, clientFilter)).Scan(&vData.PendingTasks)
		_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE assigned_to = %d AND status = 'Verified' %s", userID, clientFilter)).Scan(&vData.VerifiedTasks)

		data["VerifierData"] = vData
		c.HTML(http.StatusOK, "dashboard.html", data)
		return
	}

	// 2. Reviewer Dashboard
	if strings.EqualFold(roleStr, "Reviewer") {
		var rData ReviewerDashboardData
		clientFilter := ""
		if activeClientID > 0 {
			clientFilter = fmt.Sprintf(" AND ct.case_id IN (SELECT id FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = %d))", activeClientID)
		}
		_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE status = 'Verified' %s", clientFilter)).Scan(&rData.TasksToReview)
		_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE status = 'Completed' %s", clientFilter)).Scan(&rData.CompletedTasks)

		data["ReviewerData"] = rData
		c.HTML(http.StatusOK, "dashboard.html", data)
		return
	}

	// 3. Admin / Manager / BEO / DEV Dashboard
	now := time.Now()
	validPeriods := map[string]PeriodInfo{
		"today": {
			Key:   "today",
			Label: "Today",
			Badge: fmt.Sprintf("Today (%s)", now.Format("02 Jan 2006")),
			Short: "Today",
		},
		"week": {
			Key:   "week",
			Label: "This Week",
			Badge: fmt.Sprintf("This Week (Week %d)", now.YearDay()/7+1),
			Short: "Week",
		},
		"month": {
			Key:   "month",
			Label: "This Month",
			Badge: now.Format("January 2006"),
			Short: "Month",
		},
		"year": {
			Key:   "year",
			Label: "This Year",
			Badge: fmt.Sprintf("Year %d", now.Year()),
			Short: "Year",
		},
		"lifetime": {
			Key:   "lifetime",
			Label: "Lifetime",
			Badge: "All Time / Lifetime",
			Short: "Lifetime",
		},
	}

	period := c.DefaultQuery("period", "today")
	periodInfo, ok := validPeriods[period]
	if !ok {
		period = "today"
		periodInfo = validPeriods["today"]
	}
	data["CurrentPeriod"] = period
	data["PeriodInfo"] = periodInfo

	clientSqlCase := ""
	clientSqlCt := ""
	if activeClientID > 0 {
		clientSqlCase = fmt.Sprintf(" AND cs.client_id = %d", activeClientID)
		clientSqlCt = fmt.Sprintf(" AND ct.case_id IN (SELECT id FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = %d))", activeClientID)
	}

	condCaseCreated := getDateSqlCondition("c.created_at", period)
	condCtCreated := getDateSqlCondition("ct.created_at", period)
	condCtVerified := fmt.Sprintf("(%s OR (ct.status IN ('Verified', 'Completed') AND %s))", getDateSqlCondition("ct.verified_at", period), getDateSqlCondition("ct.created_at", period))
	condCtCompleted := fmt.Sprintf("(ct.status = 'Completed' AND (%s OR %s))", getDateSqlCondition("ct.verified_at", period), getDateSqlCondition("ct.created_at", period))
	condCtPositive := fmt.Sprintf("(ct.outcome = 'Positive' AND (%s OR %s))", getDateSqlCondition("ct.verified_at", period), getDateSqlCondition("ct.created_at", period))
	condCtNegative := fmt.Sprintf("(ct.outcome = 'Negative' AND (%s OR %s))", getDateSqlCondition("ct.verified_at", period), getDateSqlCondition("ct.created_at", period))

	// Period KPIs
	var kpi PeriodKPI
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM cases c JOIN client_structures cs ON c.structure_id = cs.id WHERE %s %s", condCaseCreated, clientSqlCase)).Scan(&kpi.Cases)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE %s %s", condCtCreated, clientSqlCt)).Scan(&kpi.TasksCreated)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE %s %s", condCtVerified, clientSqlCt)).Scan(&kpi.TasksVerified)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE %s %s", condCtCompleted, clientSqlCt)).Scan(&kpi.TasksCompleted)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE %s %s", condCtPositive, clientSqlCt)).Scan(&kpi.Positive)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE %s %s", condCtNegative, clientSqlCt)).Scan(&kpi.Negative)
	_ = db.QueryRow(fmt.Sprintf("SELECT COUNT(*) FROM case_tasks ct WHERE ct.status IN ('Pending', 'Assigned') %s", clientSqlCt)).Scan(&kpi.PendingQueue)
	data["PeriodKPI"] = kpi

	// Task-Wise Activity
	showAllTasks := c.Query("show_all_tasks") == "1"
	data["ShowAllTasks"] = showAllTasks

	taskQuery := fmt.Sprintf(`
		SELECT 
			t.id, t.task_name, t.task_type,
			COUNT(ct.id) as total_all_time,
			SUM(CASE WHEN ct.status IN ('Pending', 'Assigned') THEN 1 ELSE 0 END) as pending_count,
			SUM(CASE WHEN %s THEN 1 ELSE 0 END) as period_created,
			SUM(CASE WHEN %s THEN 1 ELSE 0 END) as period_verified,
			SUM(CASE WHEN %s THEN 1 ELSE 0 END) as period_completed,
			SUM(CASE WHEN %s THEN 1 ELSE 0 END) as period_positive,
			SUM(CASE WHEN %s THEN 1 ELSE 0 END) as period_negative
		FROM tasks t
		LEFT JOIN case_tasks ct ON t.id = ct.task_id %s
		GROUP BY t.id, t.task_name, t.task_type
		ORDER BY (CASE WHEN (SUM(CASE WHEN %s THEN 1 ELSE 0 END) > 0 OR SUM(CASE WHEN %s THEN 1 ELSE 0 END) > 0 OR SUM(CASE WHEN %s THEN 1 ELSE 0 END) > 0) THEN 0 ELSE 1 END), period_created DESC, period_verified DESC, pending_count DESC, t.task_name ASC
	`, condCtCreated, condCtVerified, condCtCompleted, condCtPositive, condCtNegative, clientSqlCt, condCtCreated, condCtVerified, condCtCompleted)

	var taskStats []TaskStatRow
	totalTaskCount := 0
	_ = db.QueryRow("SELECT COUNT(*) FROM tasks").Scan(&totalTaskCount)
	data["TotalTaskDefinitions"] = totalTaskCount

	tRows, err := db.Query(taskQuery)
	if err == nil {
		defer tRows.Close()
		for tRows.Next() {
			var r TaskStatRow
			var sAll, sPend, sCre, sVer, sCom, sPos, sNeg sql.NullInt64
			_ = tRows.Scan(&r.TaskID, &r.TaskName, &r.TaskType, &sAll, &sPend, &sCre, &sVer, &sCom, &sPos, &sNeg)
			r.TotalAllTime = int(sAll.Int64)
			r.PendingCount = int(sPend.Int64)
			r.PeriodCreated = int(sCre.Int64)
			r.PeriodVerified = int(sVer.Int64)
			r.PeriodCompleted = int(sCom.Int64)
			r.PeriodPositive = int(sPos.Int64)
			r.PeriodNegative = int(sNeg.Int64)

			hasData := (r.PeriodCreated > 0 || r.PeriodVerified > 0 || r.PeriodCompleted > 0 || r.PendingCount > 0 || (period == "lifetime" && r.TotalAllTime > 0))
			if showAllTasks || hasData {
				taskStats = append(taskStats, r)
			}
		}
	}
	data["TaskStats"] = taskStats

	// Client-Wise or Structure-Wise Breakdown
	condClientCases := getDateSqlCondition("ca.created_at", period)
	var clientStats []ClientStatRow
	var structureStats []StructureStatRow

	if activeClientID > 0 {
		// Structure-wise breakdown for selected client
		structQuery := fmt.Sprintf(`
			SELECT 
				cs.id as structure_id,
				cs.sheet_name,
				COUNT(DISTINCT ca.id) as total_cases,
				COUNT(DISTINCT CASE WHEN %s THEN ca.id ELSE NULL END) as period_cases,
				COUNT(DISTINCT ct.id) as total_tasks,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_created,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_verified,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_completed,
				COUNT(DISTINCT CASE WHEN ct.status IN ('Pending', 'Assigned') THEN ct.id ELSE NULL END) as pending_queue
			FROM client_structures cs
			LEFT JOIN cases ca ON cs.id = ca.structure_id
			LEFT JOIN case_tasks ct ON ca.id = ct.case_id
			WHERE cs.client_id = %d
			GROUP BY cs.id, cs.sheet_name
			ORDER BY (CASE WHEN (COUNT(DISTINCT CASE WHEN %s THEN ca.id ELSE NULL END) > 0 OR COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) > 0) THEN 0 ELSE 1 END), period_cases DESC, period_tasks_created DESC, total_cases DESC, cs.sheet_name ASC
		`, condClientCases, condCtCreated, condCtVerified, condCtCompleted, activeClientID, condClientCases, condCtCreated)

		sRows, err := db.Query(structQuery)
		if err == nil {
			defer sRows.Close()
			for sRows.Next() {
				var sr StructureStatRow
				_ = sRows.Scan(&sr.StructureID, &sr.SheetName, &sr.TotalCases, &sr.PeriodCases, &sr.TotalTasks, &sr.PeriodTasksCreated, &sr.PeriodTasksVerified, &sr.PeriodTasksCompleted, &sr.PendingQueue)
				structureStats = append(structureStats, sr)
			}
		}
		data["StructureStats"] = structureStats

		// Active client particulars
		var activeClientName string
		_ = db.QueryRow("SELECT name FROM clients WHERE id = ?", activeClientID).Scan(&activeClientName)
		data["ActiveClientName"] = activeClientName
	} else {
		// Global Client-Wise Activity across all clients
		clientQuery := fmt.Sprintf(`
			SELECT 
				c.id as client_id,
				c.name as client_name,
				COUNT(DISTINCT cs.id) as total_structures,
				COUNT(DISTINCT ca.id) as total_cases,
				COUNT(DISTINCT CASE WHEN %s THEN ca.id ELSE NULL END) as period_cases,
				COUNT(DISTINCT ct.id) as total_tasks,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_created,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_verified,
				COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) as period_tasks_completed,
				COUNT(DISTINCT CASE WHEN ct.status IN ('Pending', 'Assigned') THEN ct.id ELSE NULL END) as pending_queue
			FROM clients c
			LEFT JOIN client_structures cs ON c.id = cs.client_id
			LEFT JOIN cases ca ON cs.id = ca.structure_id
			LEFT JOIN case_tasks ct ON ca.id = ct.case_id
			GROUP BY c.id, c.name
			ORDER BY (CASE WHEN (COUNT(DISTINCT CASE WHEN %s THEN ca.id ELSE NULL END) > 0 OR COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) > 0 OR COUNT(DISTINCT CASE WHEN %s THEN ct.id ELSE NULL END) > 0) THEN 0 ELSE 1 END), period_cases DESC, period_tasks_created DESC, total_cases DESC, c.name ASC
		`, condClientCases, condCtCreated, condCtVerified, condCtCompleted, condClientCases, condCtCreated, condCtVerified)

		cRows, err := db.Query(clientQuery)
		if err == nil {
			defer cRows.Close()
			for cRows.Next() {
				var cr ClientStatRow
				_ = cRows.Scan(&cr.ClientID, &cr.ClientName, &cr.TotalStructures, &cr.TotalCases, &cr.PeriodCases, &cr.TotalTasks, &cr.PeriodTasksCreated, &cr.PeriodTasksVerified, &cr.PeriodTasksCompleted, &cr.PendingQueue)
				clientStats = append(clientStats, cr)
			}
		}
		data["ClientStats"] = clientStats
	}

	// All-time System counters
	var globalSummary GlobalSummary
	if activeClientID > 0 {
		_ = db.QueryRow("SELECT COUNT(*) FROM client_structures WHERE client_id = ?", activeClientID).Scan(&globalSummary.TotalStructures)
		_ = db.QueryRow("SELECT COUNT(*) FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = ?)", activeClientID).Scan(&globalSummary.TotalCases)
		_ = db.QueryRow("SELECT COUNT(*) FROM case_tasks WHERE case_id IN (SELECT id FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = ?))", activeClientID).Scan(&globalSummary.TotalTasks)
		_ = db.QueryRow("SELECT COUNT(*) FROM case_tasks WHERE status IN ('Pending', 'Assigned') AND case_id IN (SELECT id FROM cases WHERE structure_id IN (SELECT id FROM client_structures WHERE client_id = ?))", activeClientID).Scan(&globalSummary.TotalPending)
	} else {
		_ = db.QueryRow("SELECT COUNT(*) FROM users").Scan(&globalSummary.TotalUsers)
		_ = db.QueryRow("SELECT COUNT(*) FROM clients").Scan(&globalSummary.TotalClients)
		_ = db.QueryRow("SELECT COUNT(*) FROM client_structures").Scan(&globalSummary.TotalStructures)
		_ = db.QueryRow("SELECT COUNT(*) FROM cases").Scan(&globalSummary.TotalCases)
		_ = db.QueryRow("SELECT COUNT(*) FROM case_tasks").Scan(&globalSummary.TotalTasks)
		_ = db.QueryRow("SELECT COUNT(*) FROM case_tasks WHERE status IN ('Pending', 'Assigned')").Scan(&globalSummary.TotalPending)
	}
	data["GlobalSummary"] = globalSummary

	// Fetch recent 10 operational cases
	var recentCases []DashboardCaseItem
	caseQuery := `
		SELECT c.id, COALESCE(cl.name, 'Client') as client_name, COALESCE(cs.sheet_name, 'Format') as structure_name,
		       COALESCE(c.status, 'Pending'), c.is_closed, COALESCE(DATE_FORMAT(c.created_at, '%d-%b-%Y'), '-'),
		       (SELECT COUNT(*) FROM case_tasks ct WHERE ct.case_id = c.id) as task_count,
		       COALESCE((SELECT cd.data_value FROM case_data cd JOIN structure_columns sc ON cd.column_id = sc.id 
		        WHERE cd.case_id = c.id AND (sc.excel_column_name LIKE '%applicant%' OR sc.excel_column_name LIKE '%name%') LIMIT 1), CONCAT('Case #', c.id)) as applicant_name
		FROM cases c
		LEFT JOIN client_structures cs ON c.structure_id = cs.id
		LEFT JOIN clients cl ON cs.client_id = cl.id
	`
	if activeClientID > 0 {
		caseQuery += fmt.Sprintf(" WHERE cs.client_id = %d", activeClientID)
	}
	caseQuery += " ORDER BY c.id DESC LIMIT 10"

	rows, err := db.Query(caseQuery)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var item DashboardCaseItem
			_ = rows.Scan(&item.ID, &item.ClientName, &item.StructureName, &item.OverallStatus, &item.IsClosed, &item.CreatedAt, &item.TaskCount, &item.ApplicantName)
			item.TAT = "-"
			recentCases = append(recentCases, item)
		}
	}
	data["RecentCases"] = recentCases

	// Preserve backward compatibility for any views looking for KPI struct
	data["KPI"] = DashboardKPI{
		TotalCases:      globalSummary.TotalCases,
		PendingTasks:    kpi.PendingQueue,
		CompletedTasks:  kpi.TasksCompleted,
		ReviewQueue:     kpi.TasksVerified,
		PositiveCases:   kpi.Positive,
		NegativeCases:   kpi.Negative,
		PendingOutcomes: kpi.PendingQueue,
	}

	c.HTML(http.StatusOK, "dashboard.html", data)
}
