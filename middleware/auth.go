package middleware

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/utils"
)

// AuthRequired ensures user is logged in
func AuthRequired() gin.HandlerFunc {
	return func(c *gin.Context) {
		session := sessions.Default(c)
		userID := session.Get("user_id")
		if userID == nil {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
		}

		c.Set("user_id", userID)
		c.Set("username", session.Get("username"))
		c.Set("role_id", session.Get("role_id"))
		c.Set("role_name", session.Get("role_name"))
		c.Set("active_client_id", session.Get("active_client_id"))
		c.Set("original_admin_id", session.Get("original_admin_id"))

		c.Next()
	}
}

// RequireRole ensures logged in user has one of the allowed roles
func RequireRole(allowedRoles ...string) gin.HandlerFunc {
	return func(c *gin.Context) {
		roleNameVal, exists := c.Get("role_name")
		if !exists {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
		}

		roleName, _ := roleNameVal.(string)
		if !utils.CurrentUserHasRole(roleName, allowedRoles) {
			c.HTML(http.StatusForbidden, "includes/error.html", gin.H{
				"Title":   "Access Denied",
				"Message": "You do not have the necessary permissions to access this page.",
			})
			c.Abort()
			return
		}

		c.Next()
	}
}

// BaseContextMiddleware populates common UI data for all pages (nav, clients, flash messages, db health)
func BaseContextMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		session := sessions.Default(c)

		var successMsg, errorMsg string
		if s := session.Get("success"); s != nil {
			successMsg = s.(string)
			session.Delete("success")
		}
		if e := session.Get("error"); e != nil {
			errorMsg = e.(string)
			session.Delete("error")
		}
		_ = session.Save()

		// Check database status
		var dbErrorStr string
		if dbErr := database.GetDBError(); dbErr != nil {
			dbErrorStr = dbErr.Error()
		}

		// Get all clients for top bar switcher
		db := database.GetDB()
		var clients []map[string]interface{}
		if db != nil && dbErrorStr == "" {
			rows, err := db.Query("SELECT id, name FROM clients ORDER BY name ASC")
			if err == nil {
				defer rows.Close()
				for rows.Next() {
					var cid int
					var cname string
					_ = rows.Scan(&cid, &cname)
					clients = append(clients, map[string]interface{}{
						"ID":   cid,
						"Name": cname,
					})
				}
			} else {
				dbErrorStr = fmt.Sprintf("Query error on clients: %v", err)
			}
		}

		c.Set("flash_success", successMsg)
		c.Set("flash_error", errorMsg)
		c.Set("all_clients", clients)
		c.Set("db_error", dbErrorStr)

		c.Next()
	}
}

// GetBaseTemplateData returns a map populated with standard navigation and user context
func GetBaseTemplateData(c *gin.Context, pageTitle, currentPath string) gin.H {
	session := sessions.Default(c)
	var activeClientID interface{} = session.Get("active_client_id")
	if activeClientID == nil {
		activeClientID = 0
	}

	flashSuccess, _ := c.Get("flash_success")
	flashError, _ := c.Get("flash_error")
	clients, _ := c.Get("all_clients")
	dbError, _ := c.Get("db_error")

	roleName, _ := c.Get("role_name")
	username, _ := c.Get("username")
	userID, _ := c.Get("user_id")
	origAdminID := session.Get("original_admin_id")

	isVerifierOrReviewer := false
	if r, ok := roleName.(string); ok {
		if strings.EqualFold(r, "Verifier") || strings.EqualFold(r, "Reviewer") {
			isVerifierOrReviewer = true
		}
	}

	return gin.H{
		"PageTitle":            pageTitle,
		"CurrentPath":          currentPath,
		"UserID":               userID,
		"Username":             username,
		"RoleName":             roleName,
		"ActiveClientID":       activeClientID,
		"OriginalAdminID":      origAdminID,
		"AllClients":           clients,
		"FlashSuccess":         flashSuccess,
		"FlashError":           flashError,
		"DBError":              dbError,
		"IsVerifierOrReviewer": isVerifierOrReviewer,
	}
}
