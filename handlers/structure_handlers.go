package handlers

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/models"
)

type StructureListItem struct {
	ID            int
	ClientID      int
	ClientName    string
	StructureName string
	ColumnCount   int
	CreatedAt     string
}

// ListStructures displays dynamic client schemas
func ListStructures(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Client Form Structures", "/structures")
	db := database.GetDB()

	var structures []StructureListItem
	var clients []models.Client

	if db != nil {
		// Fetch clients for dropdown
		cRows, _ := db.Query("SELECT id, name FROM clients ORDER BY name ASC")
		if cRows != nil {
			defer cRows.Close()
			for cRows.Next() {
				var cl models.Client
				_ = cRows.Scan(&cl.ID, &cl.Name)
				clients = append(clients, cl)
			}
		}

		q := `
			SELECT cs.id, cs.client_id, cl.name as client_name, cs.structure_name, cs.created_at,
			       (SELECT COUNT(*) FROM structure_columns sc WHERE sc.structure_id = cs.id) as column_count
			FROM client_structures cs
			JOIN clients cl ON cs.client_id = cl.id
			ORDER BY cl.name ASC, cs.structure_name ASC
		`
		rows, err := db.Query(q)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var item StructureListItem
				var rawCreated time.Time
				_ = rows.Scan(&item.ID, &item.ClientID, &item.ClientName, &item.StructureName, &rawCreated, &item.ColumnCount)
				item.CreatedAt = rawCreated.Format("02-Jan-2006")
				structures = append(structures, item)
			}
		}
	}

	data["Structures"] = structures
	data["Clients"] = clients

	c.HTML(http.StatusOK, "structures/list.html", data)
}

// SaveStructure creates a new dynamic structure
func SaveStructure(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	name := strings.TrimSpace(c.PostForm("structure_name"))

	if clientID == 0 || name == "" {
		session.Set("error", "Client and structure name are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/structures")
		return
	}

	db := database.GetDB()
	res, err := db.Exec("INSERT INTO client_structures (client_id, structure_name, created_at) VALUES (?, ?, NOW())", clientID, name)
	if err != nil {
		session.Set("error", "Error creating structure: "+err.Error())
		_ = session.Save()
		c.Redirect(http.StatusFound, "/structures")
		return
	}

	newID, _ := res.LastInsertId()
	session.Set("success", "Structure created! Now configure its columns.")
	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/structures/edit?id=%d", newID))
}

// EditStructure displays columns configuration builder
func EditStructure(c *gin.Context) {
	structID, _ := strconv.Atoi(c.DefaultQuery("id", c.Query("structure_id")))
	if structID == 0 {
		c.Redirect(http.StatusFound, "/structures")
		return
	}

	db := database.GetDB()
	var s models.ClientStructure
	err := db.QueryRow("SELECT cs.id, cs.client_id, cl.name as client_name, cs.structure_name FROM client_structures cs JOIN clients cl ON cs.client_id = cl.id WHERE cs.id = ?", structID).Scan(
		&s.ID, &s.ClientID, &s.ClientName, &s.StructureName,
	)
	if err != nil {
		c.Redirect(http.StatusFound, "/structures")
		return
	}

	var columns []models.StructureColumn
	rows, err := db.Query(`
		SELECT id, structure_id, column_name, display_name, data_type, is_mandatory, dropdown_options, calculated_formula, calculated_function, order_index
		FROM structure_columns
		WHERE structure_id = ?
		ORDER BY order_index ASC, id ASC
	`, structID)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var col models.StructureColumn
			_ = rows.Scan(&col.ID, &col.StructureID, &col.ColumnName, &col.DisplayName, &col.DataType, &col.IsMandatory, &col.DropdownOptions, &col.CalculatedFormula, &col.CalculatedFunction, &col.OrderIndex)
			columns = append(columns, col)
		}
	}

	data := middleware.GetBaseTemplateData(c, fmt.Sprintf("Edit Schema: %s", s.StructureName), "/structures")
	data["Structure"] = s
	data["Columns"] = columns

	c.HTML(http.StatusOK, "structures/edit.html", data)
}

// SaveStructureColumn adds or updates a schema column
func SaveStructureColumn(c *gin.Context) {
	session := sessions.Default(c)
	structID, _ := strconv.Atoi(c.PostForm("structure_id"))
	colName := strings.TrimSpace(c.PostForm("column_name"))
	dispName := strings.TrimSpace(c.PostForm("display_name"))
	dataType := strings.TrimSpace(c.PostForm("data_type"))
	isMandatory, _ := strconv.Atoi(c.PostForm("is_mandatory"))
	options := strings.TrimSpace(c.PostForm("dropdown_options"))
	calcFunction := strings.TrimSpace(c.PostForm("calculated_function"))

	if structID == 0 || colName == "" || dispName == "" {
		session.Set("error", "Column name and display label are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, fmt.Sprintf("/structures/edit?id=%d", structID))
		return
	}

	// Sanitize column name (snake_case)
	colName = strings.ToLower(strings.ReplaceAll(colName, " ", "_"))

	db := database.GetDB()
	_, err := db.Exec(`
		INSERT INTO structure_columns (structure_id, column_name, display_name, data_type, is_mandatory, dropdown_options, calculated_function, order_index)
		VALUES (?, ?, ?, ?, ?, ?, ?, 99)
	`, structID, colName, dispName, dataType, isMandatory, options, calcFunction)

	if err != nil {
		session.Set("error", "Error adding column: "+err.Error())
	} else {
		session.Set("success", fmt.Sprintf("Column '%s' added successfully.", dispName))
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/structures/edit?id=%d", structID))
}

// DeleteStructureColumn removes a column
func DeleteStructureColumn(c *gin.Context) {
	session := sessions.Default(c)
	colID, _ := strconv.Atoi(c.Param("id"))
	structID, _ := strconv.Atoi(c.Query("structure_id"))

	db := database.GetDB()
	_, err := db.Exec("DELETE FROM structure_columns WHERE id = ?", colID)
	if err != nil {
		session.Set("error", "Error deleting column: "+err.Error())
	} else {
		session.Set("success", "Column deleted successfully.")
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, fmt.Sprintf("/structures/edit?id=%d", structID))
}
