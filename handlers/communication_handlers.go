package handlers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/models"
	"kprm2/utils"
)

type ClientCommRoute struct {
	ID                  int
	Name                string
	Email               string
	EmailReportsEnabled int
	SmtpAccountID       int
	WhatsappAccountID   int
	SmtpTitle           string
	WhatsappTitle       string
}

// ShowCommunicationHub renders communication settings, templates, and accounts with tabs
func ShowCommunicationHub(c *gin.Context) {
	activeTab := c.DefaultQuery("tab", "smtp")
	data := middleware.GetBaseTemplateData(c, "Communication Hub", "/communication")
	db := database.GetDB()

	var smtpAccounts []models.CommunicationAccount
	var waAccounts []models.CommunicationAccount
	var allAccounts []models.CommunicationAccount
	var templates []models.CommunicationTemplate
	var clientRoutes []ClientCommRoute

	if db != nil {
		// Accounts
		aRows, _ := db.Query("SELECT id, account_type, title, config_json, is_default, status, created_at FROM communication_accounts ORDER BY is_default DESC, id ASC")
		if aRows != nil {
			defer aRows.Close()
			for aRows.Next() {
				var a models.CommunicationAccount
				_ = aRows.Scan(&a.ID, &a.Channel, &a.AccountName, &a.ConfigJSON, &a.IsDefault, &a.Status, &a.CreatedAt)
				allAccounts = append(allAccounts, a)
				if a.Channel == "smtp" {
					smtpAccounts = append(smtpAccounts, a)
				} else if a.Channel == "whatsapp" {
					waAccounts = append(waAccounts, a)
				}
			}
		}

		// Templates
		tRows, _ := db.Query("SELECT id, name, channel, COALESCE(subject, ''), body, COALESCE(event_trigger, 'manual') FROM communication_templates ORDER BY id ASC")
		if tRows != nil {
			defer tRows.Close()
			for tRows.Next() {
				var t models.CommunicationTemplate
				var subj, ev string
				_ = tRows.Scan(&t.ID, &t.EventName, &t.Channel, &subj, &t.Body, &ev)
				t.Subject = sql.NullString{String: subj, Valid: true}
				t.IsActive = 1
				templates = append(templates, t)
			}
		}

		// Client Routes
		crRows, _ := db.Query(`
			SELECT c.id, c.name, COALESCE(c.email, ''), COALESCE(c.email_reports_enabled, 1),
			       COALESCE(c.smtp_account_id, 0), COALESCE(c.whatsapp_account_id, 0),
			       COALESCE(sa.title, 'Default SMTP'), COALESCE(wa.title, 'Default WhatsApp')
			FROM clients c
			LEFT JOIN communication_accounts sa ON c.smtp_account_id = sa.id
			LEFT JOIN communication_accounts wa ON c.whatsapp_account_id = wa.id
			ORDER BY c.name ASC
		`)
		if crRows != nil {
			defer crRows.Close()
			for crRows.Next() {
				var cr ClientCommRoute
				_ = crRows.Scan(&cr.ID, &cr.Name, &cr.Email, &cr.EmailReportsEnabled, &cr.SmtpAccountID, &cr.WhatsappAccountID, &cr.SmtpTitle, &cr.WhatsappTitle)
				clientRoutes = append(clientRoutes, cr)
			}
		}
	}

	data["ActiveTab"] = activeTab
	data["SmtpAccounts"] = smtpAccounts
	data["WhatsappAccounts"] = waAccounts
	data["Accounts"] = allAccounts
	data["Templates"] = templates
	data["ClientRoutes"] = clientRoutes

	c.HTML(http.StatusOK, "communication/index.html", data)
}

// SaveCommunicationAccount creates or updates WhatsApp / SMTP account
func SaveCommunicationAccount(c *gin.Context) {
	session := sessions.Default(c)
	accountID, _ := strconv.Atoi(c.PostForm("account_id"))
	channel := strings.ToLower(strings.TrimSpace(c.PostForm("channel")))
	title := strings.TrimSpace(c.PostForm("title"))
	if title == "" {
		title = strings.TrimSpace(c.PostForm("account_name"))
	}
	taskType := strings.ToUpper(strings.TrimSpace(c.PostForm("task_type")))
	if taskType == "" {
		taskType = "ALL"
	}
	status := strings.ToLower(strings.TrimSpace(c.PostForm("status")))
	if status == "" {
		status = "active"
	}
	isDefault := 0
	if c.PostForm("is_default") != "" && c.PostForm("is_default") != "0" {
		isDefault = 1
	}

	if channel == "" || title == "" {
		session.Set("error", "Channel and title are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/communication?tab="+channel)
		return
	}

	configData := make(map[string]interface{})
	if channel == "whatsapp" {
		inst := strings.TrimSpace(c.PostForm("green_api_instance"))
		tok := strings.TrimSpace(c.PostForm("green_api_token"))
		waUrl := strings.TrimRight(strings.TrimSpace(c.PostForm("green_api_url")), "/")
		if waUrl == "" {
			waUrl = fmt.Sprintf("https://%s.api.greenapi.com", strings.Split(inst, "")[0])
		}
		configData["green_api_instance"] = inst
		configData["green_api_token"] = tok
		configData["green_api_url"] = waUrl
	} else {
		port, _ := strconv.Atoi(c.PostForm("smtp_port"))
		if port == 0 {
			port = 465
		}
		configData["smtp_host"] = strings.TrimSpace(c.PostForm("smtp_host"))
		configData["smtp_port"] = port
		configData["smtp_username"] = strings.TrimSpace(c.PostForm("smtp_username"))
		configData["smtp_password"] = strings.TrimSpace(c.PostForm("smtp_password"))
		configData["smtp_encryption"] = strings.ToLower(strings.TrimSpace(c.PostForm("smtp_encryption")))
		configData["smtp_from_email"] = strings.TrimSpace(c.PostForm("smtp_from_email"))
		configData["smtp_from_name"] = strings.TrimSpace(c.PostForm("smtp_from_name"))
	}
	configJSON, _ := json.Marshal(configData)

	db := database.GetDB()
	if isDefault == 1 {
		_, _ = db.Exec("UPDATE communication_accounts SET is_default = 0 WHERE account_type = ?", channel)
	}

	if accountID > 0 {
		_, err := db.Exec(`
			UPDATE communication_accounts
			SET title = ?, task_type = ?, status = ?, is_default = ?, config_json = ?
			WHERE id = ? AND account_type = ?
		`, title, taskType, status, isDefault, string(configJSON), accountID, channel)
		if err != nil {
			session.Set("error", "Error updating account: "+err.Error())
		} else {
			session.Set("success", "Account updated successfully.")
		}
	} else {
		_, err := db.Exec(`
			INSERT INTO communication_accounts (account_type, task_type, title, is_default, status, config_json, created_at)
			VALUES (?, ?, ?, ?, ?, ?, NOW())
		`, channel, taskType, title, isDefault, status, string(configJSON))
		if err != nil {
			session.Set("error", "Error creating account: "+err.Error())
		} else {
			session.Set("success", "Account created successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab="+channel)
}

// SetDefaultCommunicationAccount sets account as default
func SetDefaultCommunicationAccount(c *gin.Context) {
	session := sessions.Default(c)
	accID, _ := strconv.Atoi(c.DefaultQuery("id", c.PostForm("account_id")))

	db := database.GetDB()
	var channel string
	err := db.QueryRow("SELECT account_type FROM communication_accounts WHERE id = ?", accID).Scan(&channel)
	if err == nil {
		_, _ = db.Exec("UPDATE communication_accounts SET is_default = 0 WHERE account_type = ?", channel)
		_, _ = db.Exec("UPDATE communication_accounts SET is_default = 1 WHERE id = ?", accID)
		session.Set("success", "Account set as primary default.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab="+channel)
}

// DeleteCommunicationAccount deletes an account
func DeleteCommunicationAccount(c *gin.Context) {
	session := sessions.Default(c)
	accID, _ := strconv.Atoi(c.DefaultPostForm("account_id", c.DefaultQuery("id", c.Param("id"))))

	db := database.GetDB()
	var channel string
	_ = db.QueryRow("SELECT account_type FROM communication_accounts WHERE id = ?", accID).Scan(&channel)
	if channel == "" {
		channel = "smtp"
	}
	_, err := db.Exec("DELETE FROM communication_accounts WHERE id = ?", accID)
	if err != nil {
		session.Set("error", "Error deleting account: "+err.Error())
	} else {
		session.Set("success", "Account deleted successfully.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab="+channel)
}

// SaveCommunicationTemplate creates or updates a message template
func SaveCommunicationTemplate(c *gin.Context) {
	session := sessions.Default(c)
	tmplID, _ := strconv.Atoi(c.PostForm("template_id"))
	name := strings.TrimSpace(c.PostForm("name"))
	channel := strings.ToLower(strings.TrimSpace(c.PostForm("channel")))
	subject := strings.TrimSpace(c.PostForm("subject"))
	body := strings.TrimSpace(c.PostForm("body"))
	eventTrigger := strings.TrimSpace(c.PostForm("event_trigger"))
	if eventTrigger == "" {
		eventTrigger = "manual"
	}

	if name == "" || body == "" {
		session.Set("error", "Template name and message content are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/communication?tab=templates")
		return
	}

	db := database.GetDB()
	if tmplID > 0 {
		_, err := db.Exec("UPDATE communication_templates SET name = ?, channel = ?, subject = ?, body = ?, event_trigger = ? WHERE id = ?", name, channel, subject, body, eventTrigger, tmplID)
		if err != nil {
			session.Set("error", "Error updating template: "+err.Error())
		} else {
			session.Set("success", "Template updated successfully.")
		}
	} else {
		_, err := db.Exec("INSERT INTO communication_templates (name, channel, subject, body, event_trigger, created_at) VALUES (?, ?, ?, ?, ?, NOW())", name, channel, subject, body, eventTrigger)
		if err != nil {
			session.Set("error", "Error creating template: "+err.Error())
		} else {
			session.Set("success", "Template created successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab=templates")
}

// DeleteCommunicationTemplate deletes a message template
func DeleteCommunicationTemplate(c *gin.Context) {
	session := sessions.Default(c)
	tmplID, _ := strconv.Atoi(c.DefaultPostForm("template_id", c.Query("id")))

	db := database.GetDB()
	_, _ = db.Exec("DELETE FROM communication_templates WHERE id = ?", tmplID)
	session.Set("success", "Template deleted.")
	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab=templates")
}

// SaveClientCommunicationRoute saves client email reporting routing
func SaveClientCommunicationRoute(c *gin.Context) {
	session := sessions.Default(c)
	clientID, _ := strconv.Atoi(c.PostForm("client_id"))
	email := strings.TrimSpace(c.PostForm("email"))
	emailReportsEnabled, _ := strconv.Atoi(c.PostForm("email_reports_enabled"))
	smtpID, _ := strconv.Atoi(c.PostForm("smtp_account_id"))
	waID, _ := strconv.Atoi(c.PostForm("whatsapp_account_id"))

	db := database.GetDB()
	_, err := db.Exec(`
		UPDATE clients
		SET email = ?, email_reports_enabled = ?, smtp_account_id = NULLIF(?, 0), whatsapp_account_id = NULLIF(?, 0)
		WHERE id = ?
	`, email, emailReportsEnabled, smtpID, waID, clientID)

	if err != nil {
		session.Set("error", "Error saving client communication route: "+err.Error())
	} else {
		session.Set("success", "Client communication route saved.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab=client_routing")
}

// SendTestCommunication sends a test WhatsApp or Email
func SendTestCommunication(c *gin.Context) {
	session := sessions.Default(c)
	channel := strings.ToLower(c.PostForm("channel"))
	recipient := strings.TrimSpace(c.PostForm("recipient"))
	accountID, _ := strconv.Atoi(c.PostForm("account_id"))

	if recipient == "" || accountID == 0 {
		session.Set("error", "Recipient and account are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/communication?tab="+channel)
		return
	}

	db := database.GetDB()
	var configJSON string
	_ = db.QueryRow("SELECT config_json FROM communication_accounts WHERE id = ?", accountID).Scan(&configJSON)

	if channel == "whatsapp" {
		var cfg utils.GreenAPIConfig
		_ = json.Unmarshal([]byte(configJSON), &cfg)
		res, err := utils.SendGreenAPIText(cfg, recipient, "Test notification from KPRM2 Background Verification Platform.")
		if err != nil {
			session.Set("error", "WhatsApp dispatch failed: "+err.Error())
		} else {
			session.Set("success", fmt.Sprintf("WhatsApp message dispatched successfully! Response: %v", res))
		}
	} else {
		var cfg utils.SMTPConfig
		_ = json.Unmarshal([]byte(configJSON), &cfg)
		err := utils.SendSMTPEmail(cfg, recipient, "KPRM2 Test Email Notification", "<p>This is a test notification from KPRM2 Platform.</p>")
		if err != nil {
			session.Set("error", "Email dispatch failed: "+err.Error())
		} else {
			session.Set("success", "Email dispatched successfully!")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication?tab="+channel)
}
