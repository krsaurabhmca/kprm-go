package handlers

import (
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/models"
	"kprm2/utils"
)

// ShowLogin renders login screen
func ShowLogin(c *gin.Context) {
	session := sessions.Default(c)
	if session.Get("user_id") != nil {
		c.Redirect(http.StatusFound, "/")
		return
	}

	var errorMsg, successMsg string
	if e := session.Get("error"); e != nil {
		errorMsg = e.(string)
		session.Delete("error")
	}
	if s := session.Get("success"); s != nil {
		successMsg = s.(string)
		session.Delete("success")
	}
	_ = session.Save()

	c.HTML(http.StatusOK, "login.html", gin.H{
		"Title":   "Sign In - KPRM2",
		"Error":   errorMsg,
		"Success": successMsg,
	})
}

// ProcessLogin handles user authentication
func ProcessLogin(c *gin.Context) {
	session := sessions.Default(c)
	username := strings.TrimSpace(c.PostForm("username"))
	password := c.PostForm("password")

	if username == "" || password == "" {
		session.Set("error", "Please provide username and password.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/login")
		return
	}

	db := database.GetDB()
	var user models.User
	query := `
		SELECT u.id, u.username, u.password_hash, u.role_id, r.role_name, u.allowed_task_types
		FROM users u 
		JOIN user_roles r ON u.role_id = r.id 
		WHERE u.username = ? LIMIT 1
	`
	err := db.QueryRow(query, username).Scan(
		&user.ID,
		&user.Username,
		&user.PasswordHash,
		&user.RoleID,
		&user.RoleName,
		&user.AllowedTaskTypes,
	)

	if err != nil || !utils.CheckPassword(password, user.PasswordHash) {
		session.Set("error", "Invalid username or password.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/login")
		return
	}

	session.Set("user_id", user.ID)
	session.Set("username", user.Username)
	session.Set("role_id", user.RoleID)
	session.Set("role_name", user.RoleName)
	if user.AllowedTaskTypes.Valid {
		session.Set("allowed_task_types", user.AllowedTaskTypes.String)
	}
	_ = session.Save()

	c.Redirect(http.StatusFound, "/")
}

// ShowRegister renders registration screen
func ShowRegister(c *gin.Context) {
	db := database.GetDB()
	rows, err := db.Query("SELECT id, role_name FROM user_roles ORDER BY id ASC")
	var roles []models.UserRole
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var r models.UserRole
			_ = rows.Scan(&r.ID, &r.RoleName)
			roles = append(roles, r)
		}
	}

	session := sessions.Default(c)
	var errorMsg string
	if e := session.Get("error"); e != nil {
		errorMsg = e.(string)
		session.Delete("error")
		_ = session.Save()
	}

	c.HTML(http.StatusOK, "register.html", gin.H{
		"Title": "Register User - KPRM2",
		"Roles": roles,
		"Error": errorMsg,
	})
}

// ProcessRegister handles user registration
func ProcessRegister(c *gin.Context) {
	session := sessions.Default(c)
	username := strings.TrimSpace(c.PostForm("username"))
	password := c.PostForm("password")
	roleIDStr := c.PostForm("role_id")
	roleID, _ := strconv.Atoi(roleIDStr)

	if username == "" || password == "" || roleID == 0 {
		session.Set("error", "Please fill in all required fields.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/register")
		return
	}

	hash, err := utils.HashPassword(password)
	if err != nil {
		session.Set("error", "Error encrypting password.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/register")
		return
	}

	db := database.GetDB()
	_, err = db.Exec("INSERT INTO users (username, password_hash, role_id) VALUES (?, ?, ?)", username, hash, roleID)
	if err != nil {
		session.Set("error", "Username already exists or database error: "+err.Error())
		_ = session.Save()
		c.Redirect(http.StatusFound, "/register")
		return
	}

	session.Set("success", "Account created successfully! Please sign in.")
	_ = session.Save()
	c.Redirect(http.StatusFound, "/login")
}

// Logout terminates user session
func Logout(c *gin.Context) {
	session := sessions.Default(c)
	session.Clear()
	_ = session.Save()
	c.Redirect(http.StatusFound, "/login")
}

// SwitchClientContext toggles the active client filter in session
func SwitchClientContext(c *gin.Context) {
	session := sessions.Default(c)
	clientIDStr := strings.TrimSpace(c.PostForm("switch_client_id"))

	if clientIDStr == "" || clientIDStr == "0" {
		session.Delete("active_client_id")
	} else {
		cid, err := strconv.Atoi(clientIDStr)
		if err == nil && cid > 0 {
			session.Set("active_client_id", cid)
		}
	}
	_ = session.Save()

	referer := c.Request.Header.Get("Referer")
	if referer == "" {
		referer = "/"
	}
	c.Redirect(http.StatusFound, referer)
}

// ReturnToAdmin handles impersonation revert
func ReturnToAdmin(c *gin.Context) {
	session := sessions.Default(c)
	origID := session.Get("original_admin_id")
	if origID != nil {
		db := database.GetDB()
		var u models.User
		err := db.QueryRow("SELECT u.id, u.username, u.role_id, r.role_name FROM users u JOIN user_roles r ON u.role_id = r.id WHERE u.id = ?", origID).Scan(
			&u.ID, &u.Username, &u.RoleID, &u.RoleName,
		)
		if err == nil {
			session.Set("user_id", u.ID)
			session.Set("username", u.Username)
			session.Set("role_id", u.RoleID)
			session.Set("role_name", u.RoleName)
			session.Delete("original_admin_id")
			session.Delete("active_client_id")
			session.Set("success", "Returned back to Administrator account.")
			_ = session.Save()
			c.Redirect(http.StatusFound, "/")
			return
		}
	}
	c.Redirect(http.StatusFound, "/")
}

// CompatibilityAuthProcess forwards POST /auth_process.php
func CompatibilityAuthProcess(c *gin.Context) {
	action := c.PostForm("action")
	if action == "register" {
		ProcessRegister(c)
	} else {
		ProcessLogin(c)
	}
}
