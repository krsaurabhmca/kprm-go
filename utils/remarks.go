package utils

import (
	"fmt"
	"strings"
	"time"
)

// SubstituteTemplateTags replaces `#Placeholder#` tokens with actual context values
func SubstituteTemplateTags(template string, vars map[string]string) string {
	res := template
	for k, v := range vars {
		tokenWithHash := "#" + strings.Trim(k, "#") + "#"
		res = strings.ReplaceAll(res, tokenWithHash, v)
		// Also support {var} or {{var}} syntax for maximum flexibility
		res = strings.ReplaceAll(res, "{" + strings.Trim(k, "#") + "}", v)
		res = strings.ReplaceAll(res, "{{" + strings.Trim(k, "#") + "}}", v)
	}

	// Always provide current date if requested
	res = strings.ReplaceAll(res, "#Date#", time.Now().Format("02-Jan-2006"))
	res = strings.ReplaceAll(res, "#Current_Date#", time.Now().Format("02-Jan-2006"))
	return res
}

// FormatTaskRemarksTable formats task findings into a clean HTML table matching disp_task()
func FormatTaskRemarksTable(tasks []map[string]string, columns []string) string {
	if len(tasks) == 0 {
		return `<div class="text-muted fst-italic p-2">No verification tasks found.</div>`
	}

	if len(columns) == 0 {
		columns = []string{"sr_no", "task_name", "status", "remarks"}
	}

	var sb strings.Builder
	sb.WriteString(`<div class="table-responsive my-2">`)
	sb.WriteString(`<table class="table table-bordered table-sm align-middle fs-13 mb-0" style="border: 1px solid #e2e8f0; background: #fff;">`)
	sb.WriteString(`<thead class="table-light text-uppercase fw-semibold text-secondary" style="font-size: 11px;"><tr>`)

	for _, col := range columns {
		switch strings.ToLower(col) {
		case "sr_no", "sr_no.":
			sb.WriteString(`<th style="width: 50px;" class="text-center">Sr. No.</th>`)
		case "task_name":
			sb.WriteString(`<th>Task Details</th>`)
		case "status":
			sb.WriteString(`<th style="width: 120px;" class="text-center">Verification Status</th>`)
		case "verifier":
			sb.WriteString(`<th style="width: 140px;">Field Verifier</th>`)
		case "verified_at":
			sb.WriteString(`<th style="width: 130px;" class="text-center">Verified Date</th>`)
		case "remarks":
			sb.WriteString(`<th>Observation & Remarks</th>`)
		}
	}
	sb.WriteString(`</tr></thead><tbody>`)

	for i, t := range tasks {
		sb.WriteString(`<tr>`)
		for _, col := range columns {
			switch strings.ToLower(col) {
			case "sr_no", "sr_no.":
				sb.WriteString(fmt.Sprintf(`<td class="text-center text-muted fw-semibold">%d</td>`, i+1))
			case "task_name":
				sb.WriteString(fmt.Sprintf(`<td class="fw-semibold text-dark">%s</td>`, t["task_name"]))
			case "status":
				sb.WriteString(fmt.Sprintf(`<td class="text-center">%s</td>`, StatusBadgeHTML(t["status"])))
			case "verifier":
				sb.WriteString(fmt.Sprintf(`<td>%s</td>`, t["verifier"]))
			case "verified_at":
				sb.WriteString(fmt.Sprintf(`<td class="text-center font-monospace text-muted">%s</td>`, t["verified_at"]))
			case "remarks":
				sb.WriteString(fmt.Sprintf(`<td style="white-space: pre-line;">%s</td>`, t["remarks"]))
			}
		}
		sb.WriteString(`</tr>`)
	}

	sb.WriteString(`</tbody></table></div>`)
	return sb.String()
}

