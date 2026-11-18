package handlers

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/middleware"
)

// ViewFile displays inline file viewer
func ViewFile(c *gin.Context) {
	fileParam := c.Query("file")
	if fileParam == "" {
		c.String(http.StatusBadRequest, "No file specified.")
		return
	}

	cleanRelPath := filepath.Clean(fileParam)
	if strings.Contains(cleanRelPath, "..") {
		c.String(http.StatusForbidden, "Invalid file path.")
		return
	}

	fullPath := filepath.Join(config.AppConfig.UploadPath, cleanRelPath)
	if _, err := os.Stat(fullPath); os.IsNotExist(err) {
		c.String(http.StatusNotFound, "File not found.")
		return
	}

	ext := strings.ToLower(filepath.Ext(fullPath))
	downloadURL := fmt.Sprintf("/uploads/%s", strings.ReplaceAll(cleanRelPath, "\\", "/"))

	data := middleware.GetBaseTemplateData(c, fmt.Sprintf("View Document: %s", filepath.Base(cleanRelPath)), "/file-viewer")
	data["FileName"] = filepath.Base(cleanRelPath)
	data["FileExt"] = ext
	data["FileURL"] = downloadURL

	// Read content if text/log/csv
	if ext == ".txt" || ext == ".csv" || ext == ".log" {
		contentBytes, err := os.ReadFile(fullPath)
		if err == nil {
			data["FileContent"] = string(contentBytes)
		}
	}

	c.HTML(http.StatusOK, "file_viewer.html", data)
}

// ShowDocs renders interactive system documentation
func ShowDocs(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "System Documentation", "/docs")
	c.HTML(http.StatusOK, "docs/index.html", data)
}

