package utils

import (
	"io"

	"github.com/xuri/excelize/v2"
)

// GenerateExcelReport creates an Excel spreadsheet with styled header and border styling
func GenerateExcelReport(sheetName string, headers []string, rows [][]string, w io.Writer) error {
	f := excelize.NewFile()
	defer f.Close()

	if sheetName == "" {
		sheetName = "Report"
	}
	f.SetSheetName("Sheet1", sheetName)

	// Create Header Style (Dark Blue / Navy with white bold text, centered)
	headerStyle, err := f.NewStyle(&excelize.Style{
		Font: &excelize.Font{
			Bold:  true,
			Color: "FFFFFF",
			Size:  11,
		},
		Fill: excelize.Fill{
			Type:    "pattern",
			Color:   []string{"1E293B"},
			Pattern: 1,
		},
		Alignment: &excelize.Alignment{
			Horizontal: "center",
			Vertical:   "center",
			WrapText:   true,
		},
		Border: []excelize.Border{
			{Type: "top", Style: 1, Color: "000000"},
			{Type: "bottom", Style: 1, Color: "000000"},
			{Type: "left", Style: 1, Color: "000000"},
			{Type: "right", Style: 1, Color: "000000"},
		},
	})
	if err != nil {
		return err
	}

	// Create Data Row Style (bordered, vertical middle, wrap text)
	dataStyle, err := f.NewStyle(&excelize.Style{
		Font: &excelize.Font{
			Size: 10,
		},
		Alignment: &excelize.Alignment{
			Vertical: "center",
			WrapText: true,
		},
		Border: []excelize.Border{
			{Type: "top", Style: 1, Color: "CBD5E1"},
			{Type: "bottom", Style: 1, Color: "CBD5E1"},
			{Type: "left", Style: 1, Color: "CBD5E1"},
			{Type: "right", Style: 1, Color: "CBD5E1"},
		},
	})
	if err != nil {
		return err
	}

	// Write Headers
	for colIdx, h := range headers {
		cell, _ := excelize.CoordinatesToCellName(colIdx+1, 1)
		_ = f.SetCellValue(sheetName, cell, h)
		_ = f.SetCellStyle(sheetName, cell, cell, headerStyle)
	}
	_ = f.SetRowHeight(sheetName, 1, 28)

	// Write Rows
	colWidths := make(map[int]int)
	for colIdx, h := range headers {
		colWidths[colIdx] = len(h) + 4
		if colWidths[colIdx] < 12 {
			colWidths[colIdx] = 12
		}
	}

	for rowIdx, row := range rows {
		rowNum := rowIdx + 2
		for colIdx, val := range row {
			cell, _ := excelize.CoordinatesToCellName(colIdx+1, rowNum)
			_ = f.SetCellValue(sheetName, cell, val)
			_ = f.SetCellStyle(sheetName, cell, cell, dataStyle)

			if len(val) > colWidths[colIdx] {
				colWidths[colIdx] = len(val) + 3
				if colWidths[colIdx] > 45 {
					colWidths[colIdx] = 45
				}
			}
		}
		_ = f.SetRowHeight(sheetName, rowNum, 22)
	}

	// Set column widths
	for colIdx, w := range colWidths {
		colName, _ := excelize.ColumnNumberToName(colIdx + 1)
		_ = f.SetColWidth(sheetName, colName, colName, float64(w))
	}

	return f.Write(w)
}
