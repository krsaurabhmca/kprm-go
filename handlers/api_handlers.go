package handlers

import (
	"database/sql"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/utils"
)

// GetTaskFormAPI generates dynamic HTML form fields for task verification modal
func GetTaskFormAPI(c *gin.Context) {
	taskID, _ := strconv.Atoi(c.DefaultQuery("case_task_id", c.Query("task_id")))
	if taskID == 0 {
		c.String(http.StatusBadRequest, "Invalid task ID.")
		return
	}

	db := database.GetDB()

	// Get base task info
	var taskBlueprintID int
	var taskName, taskType string
	err := db.QueryRow(`
		SELECT ct.task_id, t.task_name, t.task_type
		FROM case_tasks ct
		JOIN tasks t ON ct.task_id = t.id
		WHERE ct.id = ?
	`, taskID).Scan(&taskBlueprintID, &taskName, &taskType)
	if err != nil {
		c.String(http.StatusNotFound, "Task not found.")
		return
	}

	// Fetch existing values
	existingValues := make(map[int]string)
	vRows, _ := db.Query("SELECT task_meta_id, data_value FROM case_task_data WHERE case_task_id = ?", taskID)
	if vRows != nil {
		defer vRows.Close()
		for vRows.Next() {
			var mID int
			var val sql.NullString
			_ = vRows.Scan(&mID, &val)
			existingValues[mID] = val.String
		}
	}

	// Fetch meta fields
	mRows, err := db.Query(`
		SELECT id, meta_key, display_name, data_type, is_required, COALESCE(options, '')
		FROM task_meta
		WHERE task_id = ?
		ORDER BY order_index ASC, id ASC
	`, taskBlueprintID)

	var sb strings.Builder
	sb.WriteString(fmt.Sprintf(`<input type="hidden" name="case_task_id" value="%d">`, taskID))

	if err == nil && mRows != nil {
		defer mRows.Close()
		for mRows.Next() {
			var mid, isReq int
			var mKey, dName, dType, opts string
			_ = mRows.Scan(&mid, &mKey, &dName, &dType, &isReq, &opts)

			val := existingValues[mid]
			reqAttr := ""
			reqLabel := ""
			if isReq == 1 {
				reqAttr = "required"
				reqLabel = ` <span class="text-danger">*</span>`
			}

			sb.WriteString(`<div class="mb-3">`)
			sb.WriteString(fmt.Sprintf(`<label class="form-label fw-semibold fs-13 text-secondary">%s%s</label>`, dName, reqLabel))

			switch strings.ToLower(dType) {
			case "textarea":
				sb.WriteString(fmt.Sprintf(`<textarea class="form-control form-control-sm" name="meta_%d" rows="3" %s>%s</textarea>`, mid, reqAttr, val))
			case "dropdown", "select":
				sb.WriteString(fmt.Sprintf(`<select class="form-select form-select-sm" name="meta_%d" %s>`, mid, reqAttr))
				sb.WriteString(`<option value="">-- Select --</option>`)
				for _, opt := range strings.Split(opts, ",") {
					opt = strings.TrimSpace(opt)
					selected := ""
					if opt == val {
						selected = "selected"
					}
					sb.WriteString(fmt.Sprintf(`<option value="%s" %s>%s</option>`, opt, selected, opt))
				}
				sb.WriteString(`</select>`)
			case "date":
				sb.WriteString(fmt.Sprintf(`<input type="date" class="form-control form-control-sm" name="meta_%d" value="%s" %s>`, mid, val, reqAttr))
			case "financial_grid", "financial_table":
				sections := utils.ParseFinancialData(val)
				sb.WriteString(utils.RenderFinancialTableHTML(sections, true, "fin_matrix"))
			default: // text
				sb.WriteString(fmt.Sprintf(`<input type="text" class="form-control form-control-sm" name="meta_%d" value="%s" %s>`, mid, val, reqAttr))
			}

			sb.WriteString(`</div>`)
		}
	}

	// Always provide attachment upload field
	sb.WriteString(`
		<div class="mb-3">
			<label class="form-label fw-semibold fs-13 text-secondary">Upload Verification Attachments (Photos/PDF)</label>
			<input type="file" name="attachments" class="form-control form-control-sm" multiple>
			<small class="text-muted">Allowed: JPG, PNG, PDF, DOCX</small>
		</div>
	`)

	c.Header("Content-Type", "text/html; charset=utf-8")
	c.String(http.StatusOK, sb.String())
}

// GetTaskRemarksAPI returns remark template with dynamic tags populated
func GetTaskRemarksAPI(c *gin.Context) {
	taskID, _ := strconv.Atoi(c.DefaultQuery("case_task_id", c.Query("task_id")))
	status := c.DefaultQuery("status", "Positive")

	if taskID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": "error", "message": "Invalid task ID"})
		return
	}

	db := database.GetDB()

	var caseID, blueprintID int
	var taskName string
	err := db.QueryRow(`
		SELECT ct.case_id, ct.task_id, t.task_name
		FROM case_tasks ct
		JOIN tasks t ON ct.task_id = t.id
		WHERE ct.id = ?
	`, taskID).Scan(&caseID, &blueprintID, &taskName)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"status": "error", "message": "Task not found"})
		return
	}

	// Fetch template
	var templateBody string
	_ = db.QueryRow("SELECT remark_template FROM task_remarks WHERE task_id = ? AND status = ? LIMIT 1", blueprintID, status).Scan(&templateBody)

	if templateBody == "" {
		templateBody = fmt.Sprintf("Verification for %s is confirmed as %s upon physical and documentary check.", taskName, status)
	}

	// Fetch dynamic tags from case
	tags := make(map[string]string)
	tags["Task_Name"] = taskName
	tags["Status"] = status

	cdRows, _ := db.Query(`
		SELECT sc.column_name, cd.data_value
		FROM case_data cd
		JOIN structure_columns sc ON cd.column_id = sc.id
		WHERE cd.case_id = ?
	`, caseID)
	if cdRows != nil {
		defer cdRows.Close()
		for cdRows.Next() {
			var col, val sql.NullString
			_ = cdRows.Scan(&col, &val)
			tags[col.String] = val.String
			if strings.Contains(strings.ToLower(col.String), "applicant") || strings.Contains(strings.ToLower(col.String), "name") {
				tags["Applicant_Name"] = val.String
			}
		}
	}

	populated := utils.SubstituteTemplateTags(templateBody, tags)
	c.JSON(http.StatusOK, gin.H{
		"status": "success",
		"remark": populated,
	})
}

// InboundTaskWebhookCallback handles webhook updates from external partner APIs
func InboundTaskWebhookCallback(c *gin.Context) {
	type WebhookPayload struct {
		TaskID        int    `json:"task_id"`
		Status        string `json:"status"`
		Remarks       string `json:"remarks"`
		AttachmentURL string `json:"attachment_url"`
	}

	var payload WebhookPayload
	if err := c.ShouldBindJSON(&payload); err != nil {
		// Try form values
		payload.TaskID, _ = strconv.Atoi(c.PostForm("task_id"))
		payload.Status = c.PostForm("status")
		payload.Remarks = c.PostForm("remarks")
		payload.AttachmentURL = c.PostForm("attachment_url")
	}

	if payload.TaskID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": "error", "message": "Missing task_id"})
		return
	}

	if payload.Status == "" {
		payload.Status = "Positive"
	}

	db := database.GetDB()
	var caseID int
	err := db.QueryRow("SELECT case_id FROM case_tasks WHERE id = ?", payload.TaskID).Scan(&caseID)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"status": "error", "message": "Task not found"})
		return
	}

	_, _ = db.Exec(`
		UPDATE case_tasks 
		SET status = ?, remarks = ?, verified_at = NOW() 
		WHERE id = ?
	`, payload.Status, payload.Remarks, payload.TaskID)

	_, _ = db.Exec("INSERT INTO case_task_history (case_task_id, status, remark) VALUES (?, ?, ?)", payload.TaskID, payload.Status, "Webhook callback: "+payload.Remarks)

	// Recalculate parent case overall status
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

	c.JSON(http.StatusOK, gin.H{
		"status":  "success",
		"message": "Task verification updated successfully",
		"task_id": payload.TaskID,
	})
}

