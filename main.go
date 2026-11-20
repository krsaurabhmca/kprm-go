package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
	"kprm2/config"
	"kprm2/database"
	"kprm2/handlers"
	"kprm2/middleware"
)

func main() {
	// 1. Load Configuration
	cfg := config.LoadConfig()
	log.Printf("🚀 Starting KPRM2 Platform (Go Edition) on port %s [Env: %s]", cfg.Port, cfg.AppEnv)

	// 2. Initialize Database Connection
	_, err := database.InitDB(cfg)
	if err != nil {
		log.Printf("⚠️ Database connection error: %v", err)
	}

	// 3. Setup Gin Router
	if cfg.AppEnv == "production" {
		gin.SetMode(gin.ReleaseMode)
	}
	r := gin.Default()

	// 4. Setup Cookie Session Store
	store := cookie.NewStore([]byte(cfg.SecretKey))
	store.Options(sessions.Options{
		Path:     "/",
		MaxAge:   86400 * 7, // 7 days
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
	})
	r.Use(sessions.Sessions("kprm2_session", store))

	// Executable directory for resolving absolute paths
	execDir := ""
	if execPath, err := os.Executable(); err == nil {
		execDir = filepath.Dir(execPath)
	}

	// 5. Locate and Parse HTML Templates
	tmplDir := resolveDir("templates", "kprm2-go/templates", filepath.Join(execDir, "templates"))
	if tmplDir == "" {
		log.Fatalf("❌ Templates directory not found!")
	}
	log.Printf("📁 Loading templates from: %s", tmplDir)
	tmpl, err := loadTemplates(tmplDir)
	if err != nil {
		log.Fatalf("❌ Error parsing HTML templates: %v", err)
	}
	r.SetHTMLTemplate(tmpl)

	// 6. Static File Serving with Robust Fallback
	staticDir := resolveDir("static", "kprm2-go/static", filepath.Join(execDir, "static"), "../public/assets", "public/assets")
	if staticDir == "" {
		log.Fatalf("❌ Static assets directory not found!")
	}
	log.Printf("📁 Serving static assets from: %s", staticDir)
	r.Static("/assets", staticDir)
	r.Static("/static", staticDir)

	// Uploads serving (shared with PHP uploads directory)
	if _, err := os.Stat(cfg.UploadPath); err == nil {
		r.Static("/uploads", cfg.UploadPath)
	}

	// 7. Base Context Middleware
	r.Use(middleware.BaseContextMiddleware())

	// 8. Public Auth Routes (Clean URLs)
	r.GET("/login", handlers.ShowLogin)
	r.POST("/login", handlers.ProcessLogin)
	r.GET("/register", handlers.ShowRegister)
	r.POST("/register", handlers.ProcessRegister)
	r.GET("/logout", handlers.Logout)

	// 9. Legacy 301 Permanent Redirects (Guarantee no .php is ever shown in browser)
	r.GET("/index.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/") })
	r.GET("/login.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/login") })
	r.POST("/login.php", handlers.ProcessLogin)
	r.GET("/register.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/register") })
	r.POST("/register.php", handlers.ProcessRegister)
	r.GET("/logout.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/logout") })
	r.POST("/auth_process.php", handlers.CompatibilityAuthProcess)
	r.POST("/auth_process", handlers.CompatibilityAuthProcess)

	r.GET("/manage_cases.php", redirectWithQuery("/cases"))
	r.GET("/view_case.php", func(c *gin.Context) {
		id := c.Query("id")
		if id == "" {
			id = c.Query("case_id")
		}
		if id != "" {
			c.Redirect(http.StatusFound, "/cases/"+id)
		} else {
			c.Redirect(http.StatusFound, "/cases")
		}
	})
	r.GET("/case_select.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/cases/new") })
	r.GET("/wizard.php", func(c *gin.Context) { c.Redirect(http.StatusMovedPermanently, "/cases/new") })
	r.GET("/case_form.php", redirectWithQuery("/cases/form"))
	r.POST("/case_form.php", handlers.SaveCase)

	r.GET("/case_tasks.php", redirectWithQuery("/tasks"))
	r.POST("/case_tasks.php", handlers.HandleLegacyCaseTasksPost)
	r.GET("/manage_tasks.php", redirectWithQuery("/tasks/blueprints"))
	r.POST("/manage_tasks.php", handlers.SaveTaskBlueprint)
	r.GET("/manage_task_meta.php", redirectWithQuery("/tasks/meta"))
	r.POST("/manage_task_meta.php", handlers.HandleTaskMetaPost)
	r.GET("/manage_task_formats.php", redirectWithQuery("/tasks/formats"))

	r.GET("/process_tasks.php", redirectWithQuery("/process"))
	r.POST("/process_tasks.php", handlers.SubmitProcessTask)
	r.GET("/review_tasks.php", redirectWithQuery("/review"))
	r.POST("/review_tasks.php", handlers.SubmitReviewDecision)

	r.GET("/clients.php", redirectWithQuery("/clients"))
	r.POST("/clients.php", handlers.SaveClient)
	r.GET("/structures.php", redirectWithQuery("/structures"))
	r.POST("/structures.php", handlers.SaveStructure)
	r.GET("/edit_structure.php", redirectWithQuery("/structures/edit"))

	r.GET("/manage_reports.php", redirectWithQuery("/reports"))
	r.GET("/generate_report.php", redirectWithQuery("/reports/generate"))
	r.GET("/edit_report_config.php", redirectWithQuery("/reports/config"))
	r.POST("/edit_report_config.php", handlers.SaveReportConfig)
	r.POST("/process_report.php", handlers.SaveReportConfig)

	r.GET("/whatsapp_chat.php", redirectWithQuery("/whatsapp"))
	r.GET("/communication.php", redirectWithQuery("/communication"))
	r.GET("/settings.php", redirectWithQuery("/settings"))
	r.POST("/settings.php", handlers.SaveSettings)
	r.GET("/users.php", redirectWithQuery("/users"))
	r.POST("/users.php", handlers.SaveUser)
	r.GET("/file_viewer.php", redirectWithQuery("/file-viewer"))
	r.GET("/docs.php", redirectWithQuery("/docs"))

	// Inbound Webhooks (No session required, authenticates via payload)
	r.GET("/api/health", handlers.HealthCheckAPI)
	r.GET("/health", handlers.HealthCheckAPI)
	r.POST("/api/task_callback.php", handlers.InboundTaskWebhookCallback)
	r.POST("/api_task_update.php", handlers.InboundTaskWebhookCallback)
	r.POST("/system/api.php", handlers.InboundTaskWebhookCallback)
	r.POST("/api/task_callback", handlers.InboundTaskWebhookCallback)
	r.POST("/api/task_update", handlers.InboundTaskWebhookCallback)

	// 10. Protected Routes (Require Login)
	authGroup := r.Group("/")
	authGroup.Use(middleware.AuthRequired())
	{
		// Context Switching & Impersonation Revert
		authGroup.POST("/switch_client", handlers.SwitchClientContext)
		authGroup.POST("/return_to_admin", handlers.ReturnToAdmin)

		// Dashboard
		authGroup.GET("/", handlers.ShowDashboard)
		authGroup.GET("/dashboard", handlers.ShowDashboard)

		// Case Management (Clean URLs)
		authGroup.GET("/cases", handlers.ListCases)
		authGroup.GET("/cases/new", handlers.ShowCaseSelect)
		authGroup.GET("/cases/form", handlers.ShowCaseForm)
		authGroup.POST("/cases/new", handlers.SaveCase)
		authGroup.GET("/cases/:id", handlers.ViewCase)
		authGroup.GET("/cases/view", handlers.ViewCase)
		authGroup.POST("/cases/:id/close", handlers.CloseCase)
		authGroup.POST("/cases/:id/delete", handlers.DeleteCase)

		// Task Assignment & Operations (Clean URLs)
		authGroup.GET("/tasks", handlers.ListTasks)
		authGroup.POST("/tasks/assign", handlers.AssignTask)
		authGroup.POST("/tasks/status", handlers.UpdateCaseTaskStatus)
		authGroup.POST("/tasks/update_status", handlers.UpdateCaseTaskStatus)
		authGroup.POST("/tasks/add", handlers.AddCaseTask)
		authGroup.POST("/tasks/delete", handlers.DeleteCaseTask)
		authGroup.GET("/tasks/blueprints", handlers.ManageTasks)
		authGroup.POST("/tasks/blueprints", handlers.SaveTaskBlueprint)
		authGroup.GET("/tasks/meta", handlers.ManageTaskMeta)
		authGroup.POST("/tasks/meta", handlers.SaveTaskMetaField)
		authGroup.POST("/tasks/meta/field", handlers.SaveTaskMetaField)
		authGroup.POST("/tasks/meta/field/delete", handlers.DeleteTaskMetaField)
		authGroup.POST("/tasks/meta/toggle", handlers.ToggleTaskMetaFlag)
		authGroup.POST("/tasks/meta/remark", handlers.SaveTaskRemark)
		authGroup.POST("/tasks/meta/remark/delete", handlers.DeleteTaskRemark)
		authGroup.GET("/tasks/formats", handlers.ManageTaskFormats)

		// Field Verification (Verifier)
		authGroup.GET("/process", handlers.ListProcessTasks)
		authGroup.POST("/process", handlers.SubmitProcessTask)

		// Quality Review (Reviewer)
		authGroup.GET("/review", handlers.ListReviewTasks)
		authGroup.POST("/review", handlers.SubmitReviewDecision)

		// Clients Management
		authGroup.GET("/clients", handlers.ListClients)
		authGroup.POST("/clients", handlers.SaveClient)
		authGroup.GET("/clients/focus", handlers.FocusClient)
		authGroup.GET("/clients/:id/focus", handlers.FocusClient)
		authGroup.POST("/clients/delete", handlers.DeleteClient)
		authGroup.POST("/clients/:id/delete", handlers.DeleteClient)

		// Dynamic Schema Builder
		authGroup.GET("/structures", handlers.ListStructures)
		authGroup.POST("/structures", handlers.SaveStructure)
		authGroup.GET("/structures/edit", handlers.EditStructure)
		authGroup.POST("/structures/edit", handlers.SaveStructureColumns)
		authGroup.POST("/edit_structure.php", handlers.SaveStructureColumns)
		authGroup.POST("/structure_columns/new", handlers.SaveStructureColumn)
		authGroup.POST("/structure_columns/:id/delete", handlers.DeleteStructureColumn)

		// Reports & MIS Exports
		authGroup.GET("/reports", handlers.ManageReports)
		authGroup.GET("/reports/config", handlers.EditReportConfig)
		authGroup.POST("/reports/config", handlers.SaveReportConfig)
		authGroup.GET("/reports/generate", handlers.GenerateReport)

		// Communication Hub & WhatsApp Live Suite
		authGroup.GET("/whatsapp", handlers.ShowWhatsAppChat)
		authGroup.GET("/communication", handlers.ShowCommunicationHub)
		authGroup.POST("/communication/account", handlers.SaveCommunicationAccount)
		authGroup.GET("/communication/account/default", handlers.SetDefaultCommunicationAccount)
		authGroup.POST("/communication/account/delete", handlers.DeleteCommunicationAccount)
		authGroup.POST("/communication/template", handlers.SaveCommunicationTemplate)
		authGroup.POST("/communication/template/delete", handlers.DeleteCommunicationTemplate)
		authGroup.POST("/communication/client_route", handlers.SaveClientCommunicationRoute)
		authGroup.POST("/communication/test", handlers.SendTestCommunication)

		// Settings & DEV Tools
		authGroup.GET("/settings", handlers.ShowSettings)
		authGroup.POST("/settings", handlers.SaveSettings)
		authGroup.POST("/settings/diagnostics/callback", handlers.SimulateWebhookCallback)

		// Users & RBAC
		authGroup.GET("/users", handlers.ListUsers)
		authGroup.POST("/users", handlers.SaveUser)
		authGroup.POST("/users/login_as", handlers.ImpersonateUser)
		authGroup.POST("/users/delete", handlers.DeleteUser)
		authGroup.POST("/users/:id/delete", handlers.DeleteUser)

		// Document Viewer & System Documentation
		authGroup.GET("/file-viewer", handlers.ViewFile)
		authGroup.GET("/docs", handlers.ShowDocs)

		// AJAX Endpoints
		authGroup.GET("/api/get_task_form", handlers.GetTaskFormAPI)
		authGroup.GET("/api/get_task_remarks", handlers.GetTaskRemarksAPI)
		authGroup.GET("/api/case_stage/:id", handlers.CaseStageModalAPI)
		authGroup.GET("/api/whatsapp_chat_api", handlers.WhatsAppChatAPI)
		authGroup.POST("/api/whatsapp_chat_api", handlers.WhatsAppChatAPI)
		authGroup.GET("/api/get_task_form.php", handlers.GetTaskFormAPI)
		authGroup.GET("/api/get_task_remarks.php", handlers.GetTaskRemarksAPI)
		authGroup.GET("/api/whatsapp_chat_api.php", handlers.WhatsAppChatAPI)
		authGroup.POST("/api/whatsapp_chat_api.php", handlers.WhatsAppChatAPI)
	}

	// 11. Start Server
	serverAddr := fmt.Sprintf(":%s", cfg.Port)
	log.Printf("⚡ Server running at http://localhost:%s", cfg.Port)
	if err := r.Run(serverAddr); err != nil {
		log.Fatalf("❌ Failed to start server: %v", err)
	}
}

// redirectWithQuery creates a handler that sends a 301 redirect while preserving the query string
func redirectWithQuery(targetPath string) gin.HandlerFunc {
	return func(c *gin.Context) {
		target := targetPath
		if q := c.Request.URL.RawQuery; q != "" {
			target += "?" + q
		}
		c.Redirect(http.StatusMovedPermanently, target)
	}
}

// resolveDir checks a list of candidate directory paths and returns the first existing directory
func resolveDir(candidates ...string) string {
	for _, dir := range candidates {
		if dir == "" {
			continue
		}
		if fi, err := os.Stat(dir); err == nil && fi.IsDir() {
			return dir
		}
	}
	return ""
}

// loadTemplates parses all templates under rootDir recursively
func loadTemplates(rootDir string) (*template.Template, error) {
	tmpl := template.New("").Funcs(template.FuncMap{
		"add": func(a, b int) int { return a + b },
		"sub": func(a, b int) int { return a - b },
		"slice": func(s string, i, j int) string {
			if len(s) == 0 {
				return ""
			}
			if i < 0 {
				i = 0
			}
			if j > len(s) {
				j = len(s)
			}
			if i >= j {
				return ""
			}
			return s[i:j]
		},
		"safeHTML": func(s string) template.HTML {
			return template.HTML(s)
		},
	})

	err := filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(path, ".html") {
			b, err := os.ReadFile(path)
			if err != nil {
				return err
			}
			rel, err := filepath.Rel(rootDir, path)
			if err != nil {
				return err
			}
			name := filepath.ToSlash(rel)
			_, err = tmpl.New(name).Parse(string(b))
			if err != nil {
				return fmt.Errorf("error parsing %s: %w", name, err)
			}

			base := filepath.Base(path)
			if base != name {
				_, _ = tmpl.New(base).Parse(string(b))
			}
		}
		return nil
	})

	return tmpl, err
}
