package handlers

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"runtime"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/utils"
)

type SystemSettingItem struct {
	Key   string
	Value string
}

type UserProfileInfo struct {
	ID       int
	Username string
	Email    string
	Mobile   string
	RoleName string
}

// ShowSettings displays Basic Settings, Profile, External APIs, File Manager, and Diagnostics
func ShowSettings(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "System Settings & DEV Tools", "/settings")
	activeTab := c.DefaultQuery("tab", "basic")

	// Normalize tab names
	if activeTab == "external_apis" {
		activeTab = "external_api"
	}

	db := database.GetDB()
	settings := make(map[string]string)
	if db != nil {
		rows, err := db.Query("SELECT setting_key, setting_value FROM system_settings")
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var k, v string
				_ = rows.Scan(&k, &v)
				settings[k] = v
			}
		}
	}

	// Defaults if not found in db
	if settings["app_name"] == "" {
		settings["app_name"] = "KPRM2"
	}
	if settings["company_name"] == "" {
		settings["company_name"] = "KPRM Solutions"
	}
	if settings["currency_symbol"] == "" {
		settings["currency_symbol"] = "₹"
	}
	if settings["app_timezone"] == "" {
		settings["app_timezone"] = "Asia/Kolkata"
	}
	if settings["footer_text"] == "" {
		settings["footer_text"] = "© 2026 KPRM2. All rights reserved."
	}
	if settings["developer_credit"] == "" {
		settings["developer_credit"] = "Crafted by Saurabh"
	}

	// Fetch current user profile info
	var profile UserProfileInfo
	userIDVal, _ := c.Get("user_id")
	userID, _ := userIDVal.(int)
	if db != nil && userID > 0 {
		var rawEmail, rawMobile sql.NullString
		_ = db.QueryRow(`
			SELECT u.id, u.username, u.email, u.mobile, COALESCE(r.role_name, 'Admin')
			FROM users u
			LEFT JOIN user_roles r ON u.role_id = r.id
			WHERE u.id = ?
		`, userID).Scan(&profile.ID, &profile.Username, &rawEmail, &rawMobile, &profile.RoleName)
		profile.Email = rawEmail.String
		profile.Mobile = rawMobile.String
	}

	// File Manager: list uploads
	type UploadFileInfo struct {
		Name     string
		Path     string
		Size     string
		ModTime  string
		Category string
	}
	var files []UploadFileInfo
	uploadRoot := config.AppConfig.UploadPath

	subdirs := []string{"tasks", "stamps", "logs"}
	for _, sub := range subdirs {
		dir := filepath.Join(uploadRoot, sub)
		entries, err := os.ReadDir(dir)
		if err == nil {
			for _, e := range entries {
				if !e.IsDir() && !strings.HasPrefix(e.Name(), ".") {
					info, _ := e.Info()
					sz := "0 KB"
					if info != nil {
						sz = fmt.Sprintf("%.1f KB", float64(info.Size())/1024.0)
					}
					files = append(files, UploadFileInfo{
						Name:     e.Name(),
						Path:     filepath.Join(sub, e.Name()),
						Size:     sz,
						ModTime:  info.ModTime().Format("02-Jan-2006 15:04"),
						Category: strings.ToUpper(sub),
					})
				}
			}
		}
	}

	// System Telemetry Info
	data["ServerOS"] = runtime.GOOS + "/" + runtime.GOARCH
	data["GoVersion"] = runtime.Version()
	data["DBName"] = config.AppConfig.DBName
	data["UploadDir"] = uploadRoot

	data["ActiveTab"] = activeTab
	data["Settings"] = settings
	data["Profile"] = profile
	data["Files"] = files

	c.HTML(http.StatusOK, "settings/index.html", data)
}

// SaveSettings updates system_settings key-values or user profile
func SaveSettings(c *gin.Context) {
	session := sessions.Default(c)
	db := database.GetDB()
	tab := c.DefaultPostForm("tab", "basic")
	action := c.PostForm("action")

	// 1. Profile Update
	if action == "update_profile" || tab == "profile" {
		userIDVal, _ := c.Get("user_id")
		userID, _ := userIDVal.(int)
		email := strings.TrimSpace(c.PostForm("email"))
		mobile := strings.TrimSpace(c.PostForm("mobile"))
		password := c.PostForm("password")

		if userID > 0 && db != nil {
			if password != "" {
				hash, _ := utils.HashPassword(password)
				_, _ = db.Exec("UPDATE users SET email = ?, mobile = ?, password_hash = ? WHERE id = ?", email, mobile, hash, userID)
			} else {
				_, _ = db.Exec("UPDATE users SET email = ?, mobile = ? WHERE id = ?", email, mobile, userID)
			}
			session.Set("success", "Profile updated successfully.")
			_ = session.Save()
		}
		c.Redirect(http.StatusFound, "/settings?tab=profile")
		return
	}

	// 2. System Settings (Basic, External APIs, etc.)
	if db != nil {
		for k, vals := range c.Request.PostForm {
			if k != "tab" && k != "action" && len(vals) > 0 {
				val := vals[0]
				_, _ = db.Exec(`
					INSERT INTO system_settings (setting_key, setting_value)
					VALUES (?, ?)
					ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)
				`, k, val)
			}
		}
	}

	session.Set("success", "Settings updated successfully.")
	_ = session.Save()

	c.Redirect(http.StatusFound, fmt.Sprintf("/settings?tab=%s", tab))
}

// SimulateWebhookCallback simulates an incoming webhook callback
func SimulateWebhookCallback(c *gin.Context) {
	session := sessions.Default(c)
	taskID := c.PostForm("task_id")
	status := c.PostForm("status")
	remarks := c.PostForm("remarks")

	if taskID == "" {
		session.Set("error", "Task ID is required for simulated callback.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/settings?tab=api_diagnostics")
		return
	}

	db := database.GetDB()
	if db != nil {
		_, err := db.Exec(`
			UPDATE case_tasks 
			SET status = 'Verified', outcome = ?, final_remark = ?, verified_at = NOW() 
			WHERE id = ?
		`, status, remarks, taskID)

		if err != nil {
			session.Set("error", "Database error updating task: "+err.Error())
		} else {
			session.Set("success", fmt.Sprintf("Simulated partner callback processed! Task #%s status updated to Verified (%s).", taskID, status))
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/settings?tab=api_diagnostics")
}
