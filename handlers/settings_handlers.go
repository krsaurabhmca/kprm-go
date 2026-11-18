package handlers

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/middleware"
)

// ShowSettings displays external APIs, File Manager, Backups, and Diagnostics
func ShowSettings(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "System Settings & Dev Tools", "/settings")
	activeTab := c.DefaultQuery("tab", "external_apis")

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

	data["ActiveTab"] = activeTab
	data["Settings"] = settings
	data["Files"] = files

	c.HTML(http.StatusOK, "settings/index.html", data)
}

// SaveSettings updates system_settings key-values
func SaveSettings(c *gin.Context) {
	session := sessions.Default(c)
	db := database.GetDB()

	for k, vals := range c.Request.PostForm {
		if k != "tab" && len(vals) > 0 {
			val := vals[0]
			_, _ = db.Exec(`
				INSERT INTO system_settings (setting_key, setting_value)
				VALUES (?, ?)
				ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)
			`, k, val)
		}
	}

	session.Set("success", "Settings updated successfully.")
	_ = session.Save()

	tab := c.DefaultPostForm("tab", "external_apis")
	c.Redirect(http.StatusFound, fmt.Sprintf("/settings?tab=%s", tab))
}

// SimulateWebhookCallback tests the inbound task update webhook
func SimulateWebhookCallback(c *gin.Context) {
	session := sessions.Default(c)
	taskID := c.PostForm("task_id")
	status := c.DefaultPostForm("status", "Positive")
	remarks := c.DefaultPostForm("remarks", "Automated verification confirmation from external partner API.")

	if taskID == "" {
		session.Set("error", "Task ID is required for simulation.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/settings?tab=api_diagnostics")
		return
	}

	db := database.GetDB()
	_, err := db.Exec(`
		UPDATE case_tasks 
		SET status = ?, remarks = ?, verified_at = NOW() 
		WHERE id = ?
	`, status, remarks, taskID)

	if err != nil {
		session.Set("error", "Simulation failed: "+err.Error())
	} else {
		session.Set("success", fmt.Sprintf("Inbound webhook simulated successfully for Task #%s with status '%s'.", taskID, status))
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/settings?tab=api_diagnostics")
}
