package utils

import (
	"encoding/json"
	"fmt"
	"math"
	"strconv"
	"strings"
)

// FinancialItem holds one line in the 10-parameter financial audit matrix
type FinancialItem struct {
	Name     string  `json:"name"`
	Provided float64 `json:"provided"`
	Records  float64 `json:"records"`
	Diff     float64 `json:"diff"`
	Status   string  `json:"status"` // "Matched", "Mismatch", "Not Provided"
}

// FinancialSection holds items under a group (P&L or Balance Sheet)
type FinancialSection struct {
	Title string          `json:"title"`
	Items []FinancialItem `json:"items"`
}

// FormatIndianCurrency formats a number into Indian notation e.g. 1000000 -> 10,00,000
func FormatIndianCurrency(val float64) string {
	isNeg := val < 0
	val = math.Abs(val)
	intPart := int64(math.Round(val))
	s := strconv.FormatInt(intPart, 10)

	if len(s) <= 3 {
		if isNeg {
			return "-₹ " + s
		}
		return "₹ " + s
	}

	last3 := s[len(s)-3:]
	rest := s[:len(s)-3]

	var parts []string
	for len(rest) > 2 {
		parts = append([]string{rest[len(rest)-2:]}, parts...)
		rest = rest[:len(rest)-2]
	}
	if len(rest) > 0 {
		parts = append([]string{rest}, parts...)
	}

	res := strings.Join(parts, ",") + "," + last3
	if isNeg {
		return "-₹ " + res
	}
	return "₹ " + res
}

// ParseFinancialData parses raw JSON or generates default 10-parameter matrix
func ParseFinancialData(rawJSON string) []FinancialSection {
	var sections []FinancialSection
	if rawJSON != "" {
		if err := json.Unmarshal([]byte(rawJSON), &sections); err == nil && len(sections) > 0 {
			return sections
		}
	}

	// Default template
	return []FinancialSection{
		{
			Title: "P & L Statement",
			Items: []FinancialItem{
				{Name: "Sales/Turnover", Status: "Matched"},
				{Name: "Purchase", Status: "Matched"},
				{Name: "Depreciation", Status: "Matched"},
				{Name: "Partner/Director Remuneration", Status: "Matched"},
				{Name: "PBT", Status: "Matched"},
			},
		},
		{
			Title: "Balance Sheet Statement",
			Items: []FinancialItem{
				{Name: "Share Capital", Status: "Matched"},
				{Name: "Fixed Assets", Status: "Matched"},
				{Name: "Sundry Creditor", Status: "Matched"},
				{Name: "Sundry debtor", Status: "Matched"},
				{Name: "Cash in hand & BANK", Status: "Matched"},
			},
		},
	}
}

// RenderFinancialTableHTML renders the styled comparison table matching PHP's view_ft()
func RenderFinancialTableHTML(sections []FinancialSection, isEdit bool, inputPrefix string) string {
	var b strings.Builder

	b.WriteString(`<div class="table-responsive my-2">`)
	b.WriteString(`<table class="table table-bordered table-sm align-middle fs-13 mb-0" style="border: 1px solid #cbd5e1; background: #fff;">`)
	b.WriteString(`<thead class="table-light text-uppercase fw-bold text-secondary" style="font-size: 11px; letter-spacing: 0.5px;">`)
	b.WriteString(`<tr>`)
	b.WriteString(`<th style="width: 32%;">Financial Parameter</th>`)
	b.WriteString(`<th style="width: 22%; text-align: right;">Provided Copy (₹)</th>`)
	b.WriteString(`<th style="width: 22%; text-align: right;">Dept. Records (₹)</th>`)
	b.WriteString(`<th style="width: 14%; text-align: right;">Variance (₹)</th>`)
	b.WriteString(`<th style="width: 10%; text-align: center;">Audit Match</th>`)
	b.WriteString(`</tr></thead><tbody>`)

	secIdx := 0
	for _, sec := range sections {
		b.WriteString(fmt.Sprintf(`<tr class="table-secondary fw-bold" style="background:#f1f5f9; color:#334155;"><td colspan="5"><i class="bi bi-folder2-open me-1"></i> %s</td></tr>`, sec.Title))
		for itemIdx, item := range sec.Items {
			variance := math.Abs(item.Provided - item.Records)
			matchBadge := `<span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1"><i class="bi bi-check-circle me-1"></i>Match</span>`
			if item.Status == "Mismatch" || (item.Provided > 0 && item.Records > 0 && variance > 0.01) {
				matchBadge = `<span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1"><i class="bi bi-x-circle me-1"></i>Mismatch</span>`
			} else if item.Provided == 0 && item.Records == 0 {
				matchBadge = `<span class="badge bg-light text-muted border px-2 py-1">-</span>`
			}

			b.WriteString(`<tr>`)
			b.WriteString(fmt.Sprintf(`<td class="fw-semibold text-dark ps-3">%s</td>`, item.Name))

			if isEdit {
				provName := fmt.Sprintf("%s[%d][%d][provided]", inputPrefix, secIdx, itemIdx)
				recName := fmt.Sprintf("%s[%d][%d][records]", inputPrefix, secIdx, itemIdx)
				paramName := fmt.Sprintf("%s[%d][%d][name]", inputPrefix, secIdx, itemIdx)
				secName := fmt.Sprintf("%s[%d][%d][section]", inputPrefix, secIdx, itemIdx)

				b.WriteString(fmt.Sprintf(`<input type="hidden" name="%s" value="%s">`, paramName, item.Name))
				b.WriteString(fmt.Sprintf(`<input type="hidden" name="%s" value="%s">`, secName, sec.Title))
				b.WriteString(fmt.Sprintf(`<td><input type="number" step="0.01" class="form-control form-control-sm text-end fin-prov" name="%s" value="%.2f"></td>`, provName, item.Provided))
				b.WriteString(fmt.Sprintf(`<td><input type="number" step="0.01" class="form-control form-control-sm text-end fin-rec" name="%s" value="%.2f"></td>`, recName, item.Records))
			} else {
				b.WriteString(fmt.Sprintf(`<td class="text-end font-monospace">%s</td>`, FormatIndianCurrency(item.Provided)))
				b.WriteString(fmt.Sprintf(`<td class="text-end font-monospace">%s</td>`, FormatIndianCurrency(item.Records)))
			}

			b.WriteString(fmt.Sprintf(`<td class="text-end font-monospace text-muted">%s</td>`, FormatIndianCurrency(variance)))
			b.WriteString(fmt.Sprintf(`<td class="text-center">%s</td>`, matchBadge))
			b.WriteString(`</tr>`)
		}
		secIdx++
	}

	b.WriteString(`</tbody></table></div>`)
	return b.String()
}

// GenerateFinancialRemarks creates the formatted numbered text summary
func GenerateFinancialRemarks(sections []FinancialSection, applicant, pan, status string) string {
	var mismatches []string
	var matches []string

	for _, sec := range sections {
		for _, item := range sec.Items {
			if item.Provided == 0 && item.Records == 0 {
				continue
			}
			variance := math.Abs(item.Provided - item.Records)
			if variance > 0.01 || item.Status == "Mismatch" {
				mismatches = append(mismatches, fmt.Sprintf("%s (Provided: %s, Records: %s, Diff: %s)", item.Name, FormatIndianCurrency(item.Provided), FormatIndianCurrency(item.Records), FormatIndianCurrency(variance)))
			} else {
				matches = append(matches, fmt.Sprintf("%s: %s", item.Name, FormatIndianCurrency(item.Provided)))
			}
		}
	}

	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("Financial Statement Verification for %s (PAN: %s) Result: %s.\n", applicant, pan, status))

	if len(mismatches) > 0 {
		sb.WriteString("Discrepancies Noted:\n")
		for i, m := range mismatches {
			sb.WriteString(fmt.Sprintf("%d. %s\n", i+1, m))
		}
	} else {
		sb.WriteString("All audited parameters matched accurately with concerned department records without variance.\n")
	}

	return sb.String()
}

