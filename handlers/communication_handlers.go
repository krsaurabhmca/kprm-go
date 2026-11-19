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

// ShowCommunicationHub renders communication settings, templates, and accounts
func ShowCommunicationHub(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "Communication Hub", "/communication")
	db := database.GetDB()

	var accounts []models.CommunicationAccount
	var templates []models.CommunicationTemplate
	var mappings []models.TaskTypeCommunication

	if db != nil {
		// Accounts
		aRows, _ := db.Query("SELECT id, account_type, title, config_json, is_default, status, created_at FROM communication_accounts ORDER BY id ASC")
		if aRows != nil {
			defer aRows.Close()
			for aRows.Next() {
				var a models.CommunicationAccount
				_ = aRows.Scan(&a.ID, &a.Channel, &a.AccountName, &a.ConfigJSON, &a.IsDefault, &a.Status, &a.CreatedAt)
				accounts = append(accounts, a)
			}
		}

		// Templates
		tRows, _ := db.Query("SELECT id, name, channel, COALESCE(subject, ''), body, 1 FROM communication_templates ORDER BY id ASC")
		if tRows != nil {
			defer tRows.Close()
			for tRows.Next() {
				var t models.CommunicationTemplate
				var subj string
				_ = tRows.Scan(&t.ID, &t.EventName, &t.Channel, &subj, &t.Body, &t.IsActive)
				t.Subject = sql.NullString{String: subj, Valid: true}
				templates = append(templates, t)
			}
		}

		// Task Type Mappings
		mRows, _ := db.Query("SELECT 0, task_type, status, COALESCE(smtp_account_id, 0), COALESCE(whatsapp_account_id, 0) FROM task_type_communication ORDER BY task_type ASC")
		if mRows != nil {
			defer mRows.Close()
			for mRows.Next() {
				var m models.TaskTypeCommunication
				_ = mRows.Scan(&m.ID, &m.TaskType, &m.Status, &m.SmtpID, &m.WhatsappID)
				mappings = append(mappings, m)
			}
		}
	}

	data["Accounts"] = accounts
	data["Templates"] = templates
	data["Mappings"] = mappings

	c.HTML(http.StatusOK, "communication/index.html", data)
}

// SaveCommunicationAccount creates or updates WhatsApp / SMTP account
func SaveCommunicationAccount(c *gin.Context) {
	session := sessions.Default(c)
	channel := strings.ToLower(strings.TrimSpace(c.PostForm("channel")))
	accountName := strings.TrimSpace(c.PostForm("account_name"))
	isDefault, _ := strconv.Atoi(c.PostForm("is_default"))

	if channel == "" || accountName == "" {
		session.Set("error", "Channel and account name are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/communication")
		return
	}

	configData := make(map[string]string)
	if channel == "whatsapp" {
		configData["green_api_instance"] = strings.TrimSpace(c.PostForm("green_api_instance"))
		configData["green_api_token"] = strings.TrimSpace(c.PostForm("green_api_token"))
		configData["green_api_url"] = strings.TrimSpace(c.PostForm("green_api_url"))
	} else {
		configData["smtp_host"] = strings.TrimSpace(c.PostForm("smtp_host"))
		configData["smtp_port"] = strings.TrimSpace(c.PostForm("smtp_port"))
		configData["smtp_username"] = strings.TrimSpace(c.PostForm("smtp_username"))
		configData["smtp_password"] = strings.TrimSpace(c.PostForm("smtp_password"))
		configData["smtp_from_email"] = strings.TrimSpace(c.PostForm("smtp_from_email"))
		configData["smtp_from_name"] = strings.TrimSpace(c.PostForm("smtp_from_name"))
	}
	configJSON, _ := json.Marshal(configData)

	db := database.GetDB()
	if isDefault == 1 {
		_, _ = db.Exec("UPDATE communication_accounts SET is_default = 0 WHERE account_type = ?", channel)
	}

	_, err := db.Exec(`
		INSERT INTO communication_accounts (account_type, title, config_json, is_default, status, created_at)
		VALUES (?, ?, ?, ?, 'active', NOW())
	`, channel, accountName, string(configJSON), isDefault)

	if err != nil {
		session.Set("error", "Error creating account: "+err.Error())
	} else {
		session.Set("success", "Communication account created successfully.")
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/communication")
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
		c.Redirect(http.StatusFound, "/communication")
		return
	}

	db := database.GetDB()
	var configJSON string
	_ = db.QueryRow("SELECT config_json FROM communication_accounts WHERE id = ?", accountID).Scan(&configJSON)

	if channel == "whatsapp" {
		var cfg utils.GreenAPIConfig
		_ = json.Unmarshal([]byte(configJSON), &cfg)
		res, err := utils.SendGreenAPIText(cfg, recipient, "Test message from KPRM2 Background Verification Platform.")
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
	c.Redirect(http.StatusFound, "/communication")
}

