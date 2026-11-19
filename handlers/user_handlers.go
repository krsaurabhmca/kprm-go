package handlers

import (
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"kprm2/database"
	"kprm2/middleware"
	"kprm2/models"
	"kprm2/utils"

	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
)

type UserViewItem struct {
	ID               int
	Username         string
	RoleID           int
	RoleName         string
	Email            string
	Mobile           string
	AllowedTaskTypes string
	CreatedAt        string
}

// ListUsers displays user management directory
func ListUsers(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "User Management & RBAC", "/users")
	db := database.GetDB()

	var users []UserViewItem
	var roles []models.UserRole

	if db != nil {
		// Fetch roles for dropdown
		rRows, _ := db.Query("SELECT id, role_name FROM user_roles ORDER BY id ASC")
		if rRows != nil {
			defer rRows.Close()
			for rRows.Next() {
				var r models.UserRole
				_ = rRows.Scan(&r.ID, &r.RoleName)
				roles = append(roles, r)
			}
		}

		q := `
			SELECT u.id, u.username, COALESCE(u.role_id, 1), COALESCE(r.role_name, 'Admin'), 
			       COALESCE(u.email, ''), COALESCE(u.mobile, ''),
			       COALESCE(u.allowed_task_types, ''),
			       COALESCE(DATE_FORMAT(u.created_at, '%d-%b-%Y'), '')
			FROM users u
			LEFT JOIN user_roles r ON u.role_id = r.id
			ORDER BY u.id DESC
		`
		rows, err := db.Query(q)
		if err != nil {
			qFallback := `
				SELECT u.id, u.username, COALESCE(u.role_id, 1), COALESCE(r.role_name, 'Admin'), 
				       COALESCE(u.email, ''), COALESCE(u.mobile, ''),
				       '',
				       COALESCE(DATE_FORMAT(u.created_at, '%d-%b-%Y'), '')
				FROM users u
				LEFT JOIN user_roles r ON u.role_id = r.id
				ORDER BY u.id DESC
			`
			rows, err = db.Query(qFallback)
		}

		if err == nil && rows != nil {
			defer rows.Close()
			for rows.Next() {
				var item UserViewItem
				_ = rows.Scan(&item.ID, &item.Username, &item.RoleID, &item.RoleName, &item.Email, &item.Mobile, &item.AllowedTaskTypes, &item.CreatedAt)
				users = append(users, item)
			}
		}
	}

	data["Users"] = users
	data["Roles"] = roles

	c.HTML(http.StatusOK, "users/list.html", data)
}

// SaveUser creates or updates a user
func SaveUser(c *gin.Context) {
	session := sessions.Default(c)
	userID, _ := strconv.Atoi(c.PostForm("user_id"))
	username := strings.TrimSpace(c.PostForm("username"))
	password := c.PostForm("password")
	roleID, _ := strconv.Atoi(c.PostForm("role_id"))
	email := strings.TrimSpace(c.PostForm("email"))
	mobile := strings.TrimSpace(c.PostForm("mobile"))
	allowedTypes := strings.TrimSpace(c.PostForm("allowed_task_types"))

	if username == "" || roleID == 0 {
		session.Set("error", "Username and role are required.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/users")
		return
	}

	db := database.GetDB()
	if userID > 0 {
		if password != "" {
			hash, _ := utils.HashPassword(password)
			_, _ = db.Exec("UPDATE users SET username = ?, password_hash = ?, role_id = ?, email = ?, mobile = ?, allowed_task_types = ? WHERE id = ?", username, hash, roleID, email, mobile, allowedTypes, userID)
		} else {
			_, _ = db.Exec("UPDATE users SET username = ?, role_id = ?, email = ?, mobile = ?, allowed_task_types = ? WHERE id = ?", username, roleID, email, mobile, allowedTypes, userID)
		}
		session.Set("success", "User updated successfully.")
	} else {
		if password == "" {
			session.Set("error", "Password is required for new user.")
			_ = session.Save()
			c.Redirect(http.StatusFound, "/users")
			return
		}
		hash, _ := utils.HashPassword(password)
		_, err := db.Exec("INSERT INTO users (username, password_hash, role_id, email, mobile, allowed_task_types, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())", username, hash, roleID, email, mobile, allowedTypes)
		if err != nil {
			session.Set("error", "Error creating user: "+err.Error())
		} else {
			session.Set("success", "User created successfully.")
		}
	}

	_ = session.Save()
	c.Redirect(http.StatusFound, "/users")
}

// ImpersonateUser allows admin to log in as another user
func ImpersonateUser(c *gin.Context) {
	session := sessions.Default(c)
	targetID, _ := strconv.Atoi(c.PostForm("user_id"))
	currentUserID, _ := c.Get("user_id")

	if targetID == 0 {
		c.Redirect(http.StatusFound, "/users")
		return
	}

	db := database.GetDB()
	var target models.User
	err := db.QueryRow("SELECT u.id, u.username, u.role_id, r.role_name, u.allowed_task_types FROM users u JOIN user_roles r ON u.role_id = r.id WHERE u.id = ?", targetID).Scan(
		&target.ID, &target.Username, &target.RoleID, &target.RoleName, &target.AllowedTaskTypes,
	)

	if err == nil {
		session.Set("original_admin_id", currentUserID)
		session.Set("user_id", target.ID)
		session.Set("username", target.Username)
		session.Set("role_id", target.RoleID)
		session.Set("role_name", target.RoleName)
		if target.AllowedTaskTypes.Valid {
			session.Set("allowed_task_types", target.AllowedTaskTypes.String)
		}
		session.Set("success", fmt.Sprintf("Logged in as '%s' (%s). Use top bar to return.", target.Username, target.RoleName))
		_ = session.Save()
		c.Redirect(http.StatusFound, "/")
		return
	}

	session.Set("error", "Failed to impersonate user.")
	_ = session.Save()
	c.Redirect(http.StatusFound, "/users")
}

// DeleteUser deletes user
func DeleteUser(c *gin.Context) {
	session := sessions.Default(c)
	userID, _ := strconv.Atoi(c.Param("id"))
	if userID == 0 {
		userID, _ = strconv.Atoi(c.PostForm("user_id"))
	}

	if userID == 1 {
		session.Set("error", "Cannot delete master administrator.")
		_ = session.Save()
		c.Redirect(http.StatusFound, "/users")
		return
	}

	db := database.GetDB()
	_, err := db.Exec("DELETE FROM users WHERE id = ?", userID)
	if err != nil {
		session.Set("error", "Error deleting user: "+err.Error())
	} else {
		session.Set("success", "User deleted successfully.")
	}
	_ = session.Save()
	c.Redirect(http.StatusFound, "/users")
}
