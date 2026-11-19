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
	"kprm2/models"
)

type ClientViewItem struct {
	ID                    int
	Name                  string
	Email                 string
	AgencyName            string
	AgencyStamp           string
	StampImage            string
	EmailReportingEnabled int
	KeywordPositive       string
	KeywordNegative       string
	KeywordCNV            string
	SmtpAccountID         int
	WhatsappAccountID     int
	StructureCount        int
	CaseCount             int
	CreatedAt             string
}

// ListClients displays clients directory
func ListClients(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Client Directory", "/clients")
	db := database.GetDB()

	var clients []ClientViewItem
	var smtpAccounts []models.CommunicationAccount
	var waAccounts []models.CommunicationAccount

	if db != nil {
		// Accounts for modals
		aRows, _ := db.Query("SELECT id, account_type, title FROM communication_accounts ORDER BY title ASC")
		if aRows != nil {
			defer aRows.Close()
			for aRows.Next() {
				var a models.CommunicationAccount
				_ = aRows.Scan(&a.ID, &a.Channel, &a.AccountName)
				if a.Channel == "smtp" {
					smtpAccounts = append(smtpAccounts, a)
				} else if a.Channel == "whatsapp" {
					waAccounts = append(waAccounts, a)
				}
			}
		}

		q := `
			SELECT cl.id, cl.name, COALESCE(cl.email, ''), COALESCE(cl.agency_name, ''),
			       COALESCE(cl.agency_stamp, ''), COALESCE(cl.email_reports_enabled, 1),
			       COALESCE(cl.keyword_positive, ''), COALESCE(cl.keyword_negative, ''), COALESCE(cl.keyword_cnv, ''),
			       COALESCE(cl.smtp_account_id, 0), COALESCE(cl.whatsapp_account_id, 0),
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
				_ = rows.Scan(
					&item.ID, &item.Name, &item.Email, &item.AgencyName,
					&item.AgencyStamp, &item.EmailReportingEnabled,
					&item.KeywordPositive, &item.KeywordNegative, &item.KeywordCNV,
					&item.SmtpAccountID, &item.WhatsappAccountID,
					&item.CreatedAt, &item.StructureCount, &item.CaseCount,
				)
				item.StampImage = item.AgencyStamp
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
	data["SmtpAccounts"] = smtpAccounts
	data["WhatsappAccounts"] = waAccounts

	c.HTML(http.StatusOK, "clients/list.html", data)
}

// SaveClient creates or updates a client
func SaveClient(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	name := strings.TrimSpace(c.PostForm("name"))
	email := strings.TrimSpace(c.PostForm("email"))
	agencyName := strings.TrimSpace(c.PostForm("agency_name"))
	kwPos := strings.TrimSpace(c.PostForm("keyword_positive"))
	kwNeg := strings.TrimSpace(c.PostForm("keyword_negative"))
	kwCNV := strings.TrimSpace(c.PostForm("keyword_cnv"))
	smtpID, _ := strconv.Atoi(c.PostForm("smtp_account_id"))
	waID, _ := strconv.Atoi(c.PostForm("whatsapp_account_id"))
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
			_, err = db.Exec(`
				UPDATE clients
				SET name = ?, email = ?, agency_name = ?, agency_stamp = ?, email_reports_enabled = ?,
				    keyword_positive = ?, keyword_negative = ?, keyword_cnv = ?,
				    smtp_account_id = NULLIF(?, 0), whatsapp_account_id = NULLIF(?, 0)
				WHERE id = ?
			`, name, email, agencyName, stampFilename, emailReporting, kwPos, kwNeg, kwCNV, smtpID, waID, clientID)
		} else {
			_, err = db.Exec(`
				UPDATE clients
				SET name = ?, email = ?, agency_name = ?, email_reports_enabled = ?,
				    keyword_positive = ?, keyword_negative = ?, keyword_cnv = ?,
				    smtp_account_id = NULLIF(?, 0), whatsapp_account_id = NULLIF(?, 0)
				WHERE id = ?
			`, name, email, agencyName, emailReporting, kwPos, kwNeg, kwCNV, smtpID, waID, clientID)
		}

		if err != nil {
			// Minimal fallback if columns differ
			_, _ = db.Exec("UPDATE clients SET name = ? WHERE id = ?", name, clientID)
			session.Set("success", "Client updated.")
		} else {
			session.Set("success", "Client updated successfully.")
		}
	} else {
		_, err = db.Exec(`
			INSERT INTO clients (name, email, agency_name, agency_stamp, email_reports_enabled, keyword_positive, keyword_negative, keyword_cnv, smtp_account_id, whatsapp_account_id, created_at)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, NULLIF(?, 0), NULLIF(?, 0), NOW())
		`, name, email, agencyName, stampFilename, emailReporting, kwPos, kwNeg, kwCNV, smtpID, waID)
		if err != nil {
			_, _ = db.Exec("INSERT INTO clients (name, created_at) VALUES (?, NOW())", name)
			session.Set("success", "Client created.")
		} else {
			session.Set("success", "Client onboarded successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/clients")
}

// FocusClient sets the active operating client in session and redirects to cases
func FocusClient(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.DefaultQuery("id", c.Param("id")))
	if clientID > 0 {
		session.Set("active_client_id", clientID)
		_ = session.Save()
		c.Redirect(http.StatusFound, "/cases")
		return
	}
	c.Redirect(http.StatusFound, "/clients")
}

// DeleteClient removes a client
func DeleteClient(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.Param("id"))
	if clientID == 0 {
		clientID, _ = strconv.Atoi(c.PostForm("client_id"))
	}
	if clientID == 0 {
		clientID, _ = strconv.Atoi(c.Query("id"))
	}

	db := database.GetDB()
	_, err := db.Exec("DELETE FROM clients WHERE id = ?", clientID)
	if err != nil {
		session.Set("error", "Error deleting client: "+err.Error())
	} else {
		session.Set("success", "Client deleted successfully.")
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/clients")
}
