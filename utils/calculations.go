package utils

import (
	"fmt"
	"math"
	"strings"
	"time"
)

// CalculateTAT returns human readable TAT between two dates or against current time
func CalculateTAT(startDateStr, endDateStr string) string {
	if strings.TrimSpace(startDateStr) == "" {
		return "N/A"
	}

	formats := []string{
		"2006-01-02 15:04:05",
		"2006-01-02",
		"02-01-2006",
		"02-Jan-2006",
	}

	var startTime, endTime time.Time
	var err error

	for _, f := range formats {
		startTime, err = time.Parse(f, strings.TrimSpace(startDateStr))
		if err == nil {
			break
		}
	}
	if err != nil {
		return "N/A"
	}

	if strings.TrimSpace(endDateStr) != "" {
		for _, f := range formats {
			endTime, err = time.Parse(f, strings.TrimSpace(endDateStr))
			if err == nil {
				break
			}
		}
	}

	if endTime.IsZero() {
		endTime = time.Now()
	}

	duration := endTime.Sub(startTime)
	if duration < 0 {
		return "0 Days"
	}

	hours := duration.Hours()
	days := math.Floor(hours / 24)
	remHours := math.Floor(math.Mod(hours, 24))

	if days == 0 {
		return fmt.Sprintf("%d hrs", int(remHours))
	} else if remHours == 0 {
		return fmt.Sprintf("%d Days", int(days))
	}
	return fmt.Sprintf("%d D, %d h", int(days), int(remHours))
}

// ComputeOverallStatus calculates parent case status based on constituent task outcomes
func ComputeOverallStatus(tasks []struct{ Status, Outcome string }) string {
	if len(tasks) == 0 {
		return "Pending"
	}

	hasNegative := false
	hasCNV := false
	allCompleted := true

	for _, t := range tasks {
		outcome := strings.TrimSpace(t.Outcome)
		if outcome == "" {
			outcome = strings.TrimSpace(t.Status)
		}

		if strings.EqualFold(outcome, "Negative") {
			hasNegative = true
		} else if strings.EqualFold(outcome, "CNV") {
			hasCNV = true
		}

		if !strings.EqualFold(outcome, "Positive") &&
			!strings.EqualFold(outcome, "Negative") &&
			!strings.EqualFold(outcome, "CNV") {
			allCompleted = false
		}
	}

	if hasNegative {
		return "Negative"
	}
	if hasCNV {
		return "CNV"
	}
	if allCompleted {
		return "Positive"
	}
	return "Pending"
}

// FormatDateString parses and reformats date strings safely
func FormatDateString(val string, targetFormat string) string {
	if strings.TrimSpace(val) == "" || val == "0000-00-00" || val == "0000-00-00 00:00:00" {
		return "-"
	}

	formats := []string{
		"2006-01-02 15:04:05",
		"2006-01-02",
		time.RFC3339,
	}

	for _, f := range formats {
		if t, err := time.Parse(f, val); err == nil {
			return t.Format(targetFormat)
		}
	}
	return val
}

// StatusBadgeHTML renders consistent Bootstrap colored badges matching PHP
func StatusBadgeHTML(status string) string {
	s := strings.TrimSpace(status)
	switch strings.ToLower(s) {
	case "positive":
		return `<span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1"><i class="bi bi-check-circle me-1"></i>Positive</span>`
	case "negative":
		return `<span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1"><i class="bi bi-x-circle me-1"></i>Negative</span>`
	case "cnv":
		return `<span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-2 py-1"><i class="bi bi-exclamation-triangle me-1"></i>CNV</span>`
	case "review pending":
		return `<span class="badge bg-info-subtle text-info-emphasis border border-info-subtle px-2 py-1"><i class="bi bi-eye me-1"></i>Review Pending</span>`
	case "in progress":
		return `<span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1"><i class="bi bi-clock me-1"></i>In Progress</span>`
	default:
		return fmt.Sprintf(`<span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1">%s</span>`, s)
	}
}

