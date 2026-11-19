package handlers

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/middleware"
)

type ClientViewItem struct {
	ID                    int
	Name                  string
	Email                 string
	AgencyName            string
	AgencyStamp           string
	EmailReportingEnabled int
	StructureCount        int
	CaseCount             int
	CreatedAt             string
}

// ListClients displays clients directory
func ListClients(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Client Directory", "/clients")
	db := database.GetDB()

	var clients []ClientViewItem
	if db != nil {
		q := `
			SELECT cl.id, cl.name, COALESCE(cl.email, ''), COALESCE(cl.agency_name, ''),
			       COALESCE(cl.agency_stamp, ''), COALESCE(cl.email_reports_enabled, 1),
			       COALESCE(DATE_FORMAT(cl.created_at, '%d-%b-%Y'), ''),
			       (SELECT COUNT(*) FROM client_structures cs WHERE cs.client_id = cl.id) as structure_count,
			       (SELECT COUNT(*) FROM cases ca JOIN client_structures cs ON ca.structure_id = cs.id WHERE cs.client_id = cl.id) as case_count
			FROM clients cl
			ORDER BY cl.name ASC
		`
		rows, err := db.Query(q)
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var item ClientViewItem
				_ = rows.Scan(&item.ID, &item.Name, &item.Email, &item.AgencyName, &item.AgencyStamp, &item.EmailReportingEnabled, &item.CreatedAt, &item.StructureCount, &item.CaseCount)
				clients = append(clients, item)
			}
		} else {
			// Fallback in case table columns are simpler
			qFallback := `
				SELECT cl.id, cl.name, COALESCE(DATE_FORMAT(cl.created_at, '%d-%b-%Y'), ''),
				       (SELECT COUNT(*) FROM client_structures cs WHERE cs.client_id = cl.id) as structure_count
				FROM clients cl
				ORDER BY cl.name ASC
			`
			fRows, fErr := db.Query(qFallback)
			if fErr == nil {
				defer fRows.Close()
				for fRows.Next() {
					var item ClientViewItem
					_ = fRows.Scan(&item.ID, &item.Name, &item.CreatedAt, &item.StructureCount)
					clients = append(clients, item)
				}
			}
		}
	}

	data["Clients"] = clients
	c.HTML(http.StatusOK, "clients/list.html", data)
}

// SaveClient creates or updates a client
func SaveClient(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	name := strings.TrimSpace(c.PostForm("name"))
	emailReporting, _ := strconv.Atoi(c.PostForm("email_reporting_enabled"))

	if name == "" {
		session.Set("error", "Client name is required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/clients")
		return
	}

	var stampFilename string
	file, err := c.FormFile("stamp_image")
	if err == nil && file != nil {
		uploadDir := filepath.Join(config.AppConfig.UploadPath, "stamps")
		_ = os.MkdirAll(uploadDir, 0755)
		stampFilename = fmt.Sprintf("%d_%s", time.Now().Unix(), filepath.Base(file.Filename))
		_ = c.SaveUploadedFile(file, filepath.Join(uploadDir, stampFilename))
	}

	db := database.GetDB()
	if clientID > 0 {
		if stampFilename != "" {
			_, err = db.Exec("UPDATE clients SET name = ?, agency_stamp = ?, email_reports_enabled = ? WHERE id = ?", name, stampFilename, emailReporting, clientID)
		} else {
			_, err = db.Exec("UPDATE clients SET name = ?, email_reports_enabled = ? WHERE id = ?", name, emailReporting, clientID)
		}
		if err != nil {
			// Fallback if column names differ
			_, _ = db.Exec("UPDATE clients SET name = ? WHERE id = ?", name, clientID)
			session.Set("success", "Client updated.")
		} else {
			session.Set("success", "Client updated successfully.")
		}
	} else {
		_, err = db.Exec("INSERT INTO clients (name, agency_stamp, email_reports_enabled, created_at) VALUES (?, ?, ?, NOW())", name, stampFilename, emailReporting)
		if err != nil {
			_, _ = db.Exec("INSERT INTO clients (name, created_at) VALUES (?, NOW())", name)
			session.Set("success", "Client created.")
		} else {
			session.Set("success", "Client created successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/clients")
}

// DeleteClient removes a client
func DeleteClient(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.Param("id"))
	if clientID == 0 {
		clientID, _ = strconv.Atoi(c.PostForm("client_id"))
	}

	db := database.GetDB()
	var caseCount int
	_ = db.QueryRow("SELECT COUNT(*) FROM cases ca JOIN client_structures cs ON ca.structure_id = cs.id WHERE cs.client_id = ?", clientID).Scan(&caseCount)

	if caseCount > 0 {
		session.Set("error", fmt.Sprintf("Cannot delete client with %d existing cases.", caseCount))
	} else {
		_, err := db.Exec("DELETE FROM clients WHERE id = ?", clientID)
		if err != nil {
			session.Set("error", "Error deleting client: "+err.Error())
		} else {
			session.Set("success", "Client deleted successfully.")
		}
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/clients")
}
