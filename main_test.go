package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/handlers"
	"kprm2/middleware"
)

func setupTestRouter(t *testing.T) *gin.Engine {
	gin.SetMode(gin.TestMode)

	cfg := config.LoadConfig()
	_, err := database.InitDB(cfg)
	if err != nil {
		t.Logf("DB Init warning: %v", err)
	}

	r := gin.New()
	r.Use(gin.Recovery())

	store := cookie.NewStore([]byte(cfg.SecretKey))
	r.Use(sessions.Sessions("kprm2_session", store))

	tmplDir := resolveDir("templates", "kprm2-go/templates", "../kprm2-go/templates")
	if tmplDir == "" {
		t.Fatalf("Templates directory not found")
	}
	tmpl, err := loadTemplates(tmplDir)
	if err != nil {
		t.Fatalf("Template load error: %v", err)
	}
	r.SetHTMLTemplate(tmpl)

	staticDir := resolveDir("static", "kprm2-go/static", "../kprm2-go/static")
	if staticDir == "" {
		t.Fatalf("Static directory not found")
	}
	r.Static("/assets", staticDir)
	r.Static("/static", staticDir)

	r.Use(middleware.BaseContextMiddleware())

	// Public Routes
	r.GET("/login", handlers.ShowLogin)
	r.POST("/login", handlers.ProcessLogin)
	r.GET("/register", handlers.ShowRegister)
	r.POST("/register", handlers.ProcessRegister)
	r.GET("/logout", handlers.Logout)

	// Legacy 301 Permanent Redirects
	r.GET("/index.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/") })
	r.GET("/login.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/login") })
	r.GET("/register.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/register") })
	r.GET("/logout.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/logout") })
	r.GET("/manage_cases.php", redirectWithQuery("/cases"))
	r.GET("/case_tasks.php", redirectWithQuery("/tasks"))
	r.GET("/process_tasks.php", redirectWithQuery("/process"))
	r.GET("/review_tasks.php", redirectWithQuery("/review"))
	r.GET("/clients.php", redirectWithQuery("/clients"))
	r.GET("/structures.php", redirectWithQuery("/structures"))
	r.GET("/manage_reports.php", redirectWithQuery("/reports"))
	r.GET("/whatsapp_chat.php", redirectWithQuery("/whatsapp"))
	r.GET("/communication.php", redirectWithQuery("/communication"))
	r.GET("/settings.php", redirectWithQuery("/settings"))
	r.GET("/users.php", redirectWithQuery("/users"))
	r.GET("/file_viewer.php", redirectWithQuery("/file-viewer"))
	r.GET("/docs.php", redirectWithQuery("/docs"))

	// Protected Routes
	authGroup := r.Group("/")
	authGroup.Use(middleware.AuthRequired())
	{
		authGroup.POST("/switch_client", handlers.SwitchClientContext)
		authGroup.POST("/return_to_admin", handlers.ReturnToAdmin)

		authGroup.GET("/", handlers.ShowDashboard)
		authGroup.GET("/dashboard", handlers.ShowDashboard)

		authGroup.GET("/cases", handlers.ListCases)
		authGroup.GET("/cases/new", handlers.ShowCaseSelect)
		authGroup.GET("/cases/form", handlers.ShowCaseForm)
		authGroup.POST("/cases/new", handlers.SaveCase)
		authGroup.GET("/cases/:id", handlers.ViewCase)
		authGroup.POST("/cases/:id/close", handlers.CloseCase)
		authGroup.POST("/cases/:id/delete", handlers.DeleteCase)

		authGroup.GET("/tasks", handlers.ListTasks)
		authGroup.POST("/tasks/assign", handlers.AssignTask)
		authGroup.GET("/tasks/blueprints", handlers.ManageTasks)
		authGroup.POST("/tasks/blueprints", handlers.SaveTaskBlueprint)
		authGroup.GET("/tasks/meta", handlers.ManageTaskMeta)
		authGroup.POST("/tasks/meta", handlers.SaveTaskMeta)
		authGroup.GET("/tasks/formats", handlers.ManageTaskFormats)

		authGroup.GET("/process", handlers.ListProcessTasks)
		authGroup.POST("/process", handlers.SubmitProcessTask)
		authGroup.GET("/review", handlers.ListReviewTasks)
		authGroup.POST("/review", handlers.SubmitReviewDecision)

		authGroup.GET("/clients", handlers.ListClients)
		authGroup.POST("/clients", handlers.SaveClient)
		authGroup.POST("/clients/:id/delete", handlers.DeleteClient)

		authGroup.GET("/structures", handlers.ListStructures)
		authGroup.POST("/structures", handlers.SaveStructure)
		authGroup.GET("/structures/edit", handlers.EditStructure)

		authGroup.GET("/reports", handlers.ManageReports)
		authGroup.GET("/reports/generate", handlers.GenerateReport)

		authGroup.GET("/whatsapp", handlers.ShowWhatsAppChat)
		authGroup.GET("/communication", handlers.ShowCommunicationHub)
		authGroup.GET("/settings", handlers.ShowSettings)
		authGroup.GET("/users", handlers.ListUsers)
		authGroup.GET("/file-viewer", handlers.ViewFile)
		authGroup.GET("/docs", handlers.ShowDocs)
	}

	return r
}

func TestStaticAssets(t *testing.T) {
	r := setupTestRouter(t)

	// Check CSS style.css
	w := httptest.NewRecorder()
	req, _ := http.NewRequest("GET", "/assets/css/style.css", nil)
	r.ServeHTTP(w, req)
	if w.Code != http.StatusOK {
		t.Fatalf("Expected 200 for /assets/css/style.css, got %d", w.Code)
	}
	if !strings.Contains(w.Body.String(), "--primary-color") {
		t.Fatalf("style.css does not contain expected CSS variable definitions")
	}

	// Check CSS custom_ui.css
	w = httptest.NewRecorder()
	req, _ = http.NewRequest("GET", "/assets/css/custom_ui.css", nil)
	r.ServeHTTP(w, req)
	if w.Code != http.StatusOK {
		t.Fatalf("Expected 200 for /assets/css/custom_ui.css, got %d", w.Code)
	}
	if !strings.Contains(w.Body.String(), "table-modern") {
		t.Fatalf("custom_ui.css does not contain expected modern table definitions")
	}

	// Check JS script.js
	w = httptest.NewRecorder()
	req, _ = http.NewRequest("GET", "/assets/js/script.js", nil)
	r.ServeHTTP(w, req)
	if w.Code != http.StatusOK {
		t.Fatalf("Expected 200 for /assets/js/script.js, got %d", w.Code)
	}
}

func TestLoginPage(t *testing.T) {
	r := setupTestRouter(t)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("GET", "/login", nil)
	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fatalf("Expected 200 for /login, got %d", w.Code)
	}

	body := w.Body.String()
	if !strings.Contains(body, "Sign In") {
		t.Fatalf("Login page does not contain 'Sign In'")
	}
	if !strings.Contains(body, "Plus Jakarta Sans") {
		t.Fatalf("Login page does not contain 'Plus Jakarta Sans'")
	}
	if !strings.Contains(body, "action=\"/login\"") {
		t.Fatalf("Login form action should be clean URL '/login'")
	}
}

func TestLegacyPHP301Redirects(t *testing.T) {
	r := setupTestRouter(t)

	redirects := map[string]string{
		"/login.php":          "/login",
		"/register.php":       "/register",
		"/logout.php":         "/logout",
		"/manage_cases.php":   "/cases",
		"/case_tasks.php":     "/tasks",
		"/process_tasks.php":  "/process",
		"/review_tasks.php":   "/review",
		"/clients.php":        "/clients",
		"/structures.php":     "/structures",
		"/manage_reports.php": "/reports",
		"/whatsapp_chat.php":  "/whatsapp",
		"/communication.php":  "/communication",
		"/settings.php":       "/settings",
		"/users.php":          "/users",
		"/docs.php":           "/docs",
		"/index.php":          "/",
	}

	for legacy, expectedTarget := range redirects {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", legacy, nil)
		r.ServeHTTP(w, req)

		if w.Code != http.StatusMovedPermanently {
			t.Errorf("Expected 301 for %s, got %d", legacy, w.Code)
		}
		loc := w.Header().Get("Location")
		if loc != expectedTarget {
			t.Errorf("For %s expected Location %s, got %s", legacy, expectedTarget, loc)
		}
	}
}

func TestAuthenticatedRoutes(t *testing.T) {
	r := setupTestRouter(t)

	// Direct session cookie simulation via test endpoint
	r.GET("/test_login", func(c *gin.Context) {
		session := sessions.Default(c)
		session.Set("user_id", 1)
		session.Set("username", "admin")
		session.Set("role_id", 1)
		session.Set("role_name", "Admin")
		_ = session.Save()
		c.String(http.StatusOK, "OK")
	})

	wAuth := httptest.NewRecorder()
	reqAuth, _ := http.NewRequest("GET", "/test_login", nil)
	r.ServeHTTP(wAuth, reqAuth)
	cookieHeader := wAuth.Header().Get("Set-Cookie")
	if cookieHeader == "" {
		t.Fatalf("Failed to retrieve test session cookie")
	}

	// Test protected pages with the session cookie
	testPages := []string{
		"/",
		"/dashboard",
		"/cases",
		"/cases/new",
		"/tasks",
		"/tasks/blueprints",
		"/tasks/meta",
		"/tasks/formats",
		"/process",
		"/review",
		"/clients",
		"/structures",
		"/reports",
		"/whatsapp",
		"/communication",
		"/settings",
		"/users",
		"/docs",
	}

	for _, page := range testPages {
		w := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", page, nil)
		req.Header.Set("Cookie", cookieHeader)
		r.ServeHTTP(w, req)

		if w.Code != http.StatusOK {
			t.Errorf("Route %s failed with status %d (body: %s)", page, w.Code, w.Body.String())
		} else {
			// Verify header styles and clean layout
			body := w.Body.String()
			if !strings.Contains(body, "/assets/css/style.css") {
				t.Errorf("Route %s is missing style.css link", page)
			}
			if !strings.Contains(body, "/assets/css/custom_ui.css") {
				t.Errorf("Route %s is missing custom_ui.css link", page)
			}
			if strings.Contains(body, "bootstrap.min.css") {
				t.Errorf("Route %s should NOT load bootstrap.min.css CDN (to prevent CSS reset conflict)", page)
			}
		}
	}
}
