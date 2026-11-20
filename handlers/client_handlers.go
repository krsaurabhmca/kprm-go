package handlers

import (
	"encoding/json"
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
	ID                    int    `json:"id"`
	Name                  string `json:"name"`
	Email                 string `json:"email"`
	AgencyName            string `json:"agency_name"`
	AgencyStamp           string `json:"agency_stamp"`
	StampImage            string `json:"stamp_image"`
	EmailReportingEnabled int    `json:"email_reports_enabled"`
	KeywordPositive       string `json:"keyword_positive"`
	KeywordNegative       string `json:"keyword_negative"`
	KeywordCNV            string `json:"keyword_cnv"`
	SmtpAccountID         int    `json:"smtp_account_id"`
	WhatsappAccountID     int    `json:"whatsapp_account_id"`
	SmtpTitle             string `json:"smtp_title"`
	WhatsappTitle         string `json:"whatsapp_title"`
	Initials              string `json:"initials"`
	StructureCount        int    `json:"structure_count"`
	CaseCount             int    `json:"case_count"`
	CreatedAt             string `json:"created_at"`
	JSONData              string `json:"-"`
}

// ListClients displays clients directory
func ListClients(c *gin.Context) {
	// Support ?delete=ID directly matching clients.php
	if delIDStr := c.Query("delete"); delIDStr != "" {
		delID, _ := strconv.Atoi(delIDStr)
		if delID > 0 {
			session := sessions.Default(c)
			db := database.GetDB()
			if db != nil {
				_, _ = db.Exec("DELETE FROM clients WHERE id = ?", delID)
				session.Set("success", "Client deleted.")
				_ = session.Save()
			}
			c.Redirect(http.StatusFound, "/clients")
			return
		}
	}

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
			       COALESCE(s.title, '') as smtp_title, COALESCE(w.title, '') as whatsapp_title,
			       COALESCE(DATE_FORMAT(cl.created_at, '%d-%b-%Y'), ''),
			       (SELECT COUNT(*) FROM client_structures cs WHERE cs.client_id = cl.id) as structure_count,
			       (SELECT COUNT(*) FROM cases ca JOIN client_structures cs ON ca.structure_id = cs.id WHERE cs.client_id = cl.id) as case_count
			FROM clients cl
			LEFT JOIN communication_accounts s ON cl.smtp_account_id = s.id
			LEFT JOIN communication_accounts w ON cl.whatsapp_account_id = w.id
			ORDER BY cl.created_at DESC, cl.id DESC
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
					&item.SmtpTitle, &item.WhatsappTitle,
					&item.CreatedAt, &item.StructureCount, &item.CaseCount,
				)
				item.StampImage = item.AgencyStamp

				// Compute initials
				cleanName := strings.TrimSpace(item.Name)
				var inits string
				for _, w := range strings.Fields(cleanName) {
					if len(w) > 0 {
						inits += strings.ToUpper(string(w[0]))
						if len(inits) >= 2 {
							break
						}
					}
				}
				if inits == "" {
					inits = "CL"
				}
				item.Initials = inits

				// JSON Data
				b, _ := json.Marshal(item)
				item.JSONData = string(b)

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
					item.Initials = "CL"
					if len(item.Name) >= 2 {
						item.Initials = strings.ToUpper(item.Name[:2])
					}
					b, _ := json.Marshal(item)
					item.JSONData = string(b)
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
	action := c.PostForm("action")

	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	if action == "add_client" {
		clientID = 0
	}

	name := strings.TrimSpace(c.PostForm("name"))
	if name == "" {
		name = strings.TrimSpace(c.PostForm("client_name"))
	}

	email := strings.TrimSpace(c.PostForm("email"))
	if email == "" {
		email = strings.TrimSpace(c.PostForm("client_email"))
	}

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
	if err != nil {
		file, err = c.FormFile("agency_stamp")
	}
	if err == nil && file != nil {
		uploadDir := filepath.Join(config.AppConfig.UploadPath, "stamps")
		_ = os.MkdirAll(uploadDir, 0755)
		stampFilename = fmt.Sprintf("%d_%s", time.Now().Unix(), filepath.Base(file.Filename))
		_ = c.SaveUploadedFile(file, filepath.Join(uploadDir, stampFilename))
	}

	db := database.GetDB()
	if db != nil {
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
	}

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
	if clientID == 0 {
		clientID, _ = strconv.Atoi(c.Query("delete"))
	}

	db := database.GetDB()
	if db != nil && clientID > 0 {
		_, err := db.Exec("DELETE FROM clients WHERE id = ?", clientID)
		if err != nil {
			session.Set("error", "Error deleting client: "+err.Error())
		} else {
			session.Set("success", "Client deleted successfully.")
		}
		_ = session.Save()
	}

	c.Redirect(http.StatusFound, "/clients")
}
