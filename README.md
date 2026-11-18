# KPRM2 - Go (Golang) Enterprise Edition

This folder (`kprm2-go`) is a complete, native **Go (Golang)** conversion of the KPRM2 Background Verification and Case Management Platform.

---

## 🌟 Key Features & Zero-Impact Guarantee

1. **Non-Destructive & Completely Standalone**:
   - Resides entirely within the `kprm2-go/` directory.
   - Does **not** modify, overwrite, or delete any of your existing PHP files, templates, or composer assets.
   - Shares the same underlying MySQL database schema and upload assets without requiring any database migrations or schema alterations.

2. **UI & Flow Parity**:
   - Replicates 100% of the UI design, CSS stylesheets (`assets/css/style.css`, `assets/css/custom_ui.css`), Javascript handlers (`assets/js/script.js`), and Bootstrap 5 responsiveness.
   - Provides identical operational routes matching standard REST endpoints and `.php` URLs (e.g. `/index.php`, `/manage_cases.php`, `/case_tasks.php`, `/process_tasks.php`, `/review_tasks.php`, `/whatsapp_chat.php`, `/generate_report.php`).

3. **Two-Way Password Compatibility**:
   - Native Bcrypt interoperability handles PHP's `$2y$` password hashes and Go's standard `$2a$` hashes transparently.
   - You can sign in using existing users without resetting credentials.

4. **Full Feature Implementation**:
   - **Operational Dashboard**: Client context switcher, KPI metrics, status distribution, and TAT tracking.
   - **Dynamic Case Ingestion**: Multi-step wizard supporting client-specific schemas without altering database tables.
   - **10-Parameter Financial Audit Matrix**: Formatted comparison between *Provided Copy* vs *Concern Department Records*, Indian currency formatting (`₹ 10,00,000`), variance calculations, and match badges.
   - **Live Green API WhatsApp Suite**: Real-time two-way messaging, multi-instance switching, QR authentication modal, privacy phone masking (`919876XXXX21`), and automated dispatch.
   - **Report Center & MIS**: Styled Excel spreadsheet exports (powered by Excelize with dark-blue headers and borders) and print-ready HTML/PDF views.
   - **Inbound Webhook Receiver**: Compatible with external partner updates via `/api/task_callback.php` and `/api_task_update.php`.

---

## 🚀 Getting Started

### Prerequisites
- Go 1.20 or newer
- MySQL Server (same MySQL database used by KPRM2)

### Configuration
The Go server automatically searches for your existing `.env` file in the parent directory (`../.env`) or locally in `kprm2-go/.env`.

Default environment parameters:
```env
PORT=8080
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASS=
DB_NAME=kprm2_db
APP_ENV=development
APP_URL=http://localhost:8080
```

### Running the Application

1. Open your terminal in the `kprm2-go` directory:
   ```powershell
   cd kprm2-go
   ```

2. Run directly with Go:
   ```powershell
   go run main.go
   ```

3. Or compile into a single high-performance binary:
   ```powershell
   go build -o kprm2.exe main.go
   ./kprm2.exe
   ```

4. Open your browser and navigate to:
   ```
   http://localhost:8080/login
   ```

---

## 🛠️ CLI Cron Maintenance Runner

To run automated maintenance and database backups using the Go CLI:
```powershell
go run cmd/cron/main.go --action=backup
go run cmd/cron/main.go --action=all
```

---

## 📂 Project Architecture

```
kprm2-go/
├── cmd/
│   └── cron/               # CLI cron & maintenance runner
├── config/                 # Environment & configuration loader
├── database/               # MySQL connection pool & utilities
├── handlers/               # HTTP request handlers & business logic
│   ├── api_handlers.go
│   ├── auth_handlers.go
│   ├── case_handlers.go
│   ├── client_handlers.go
│   ├── communication_handlers.go
│   ├── dashboard_handlers.go
│   ├── file_viewer_handlers.go
│   ├── process_handlers.go
│   ├── report_handlers.go
│   ├── review_handlers.go
│   ├── settings_handlers.go
│   ├── structure_handlers.go
│   ├── task_handlers.go
│   ├── user_handlers.go
│   └── whatsapp_handlers.go
├── middleware/             # Auth, RBAC, and context middleware
├── models/                 # Database schema models & structs
├── static/                 # CSS, JS, and UI assets (cloned from public/assets)
├── templates/              # HTML templates with full layout parity
│   ├── cases/
│   ├── clients/
│   ├── communication/
│   ├── docs/
│   ├── includes/
│   ├── process/
│   ├── reports/
│   ├── review/
│   ├── settings/
│   ├── structures/
│   ├── tasks/
│   ├── users/
│   └── whatsapp/
├── utils/                  # Bcrypt auth, financial audit, remarks, excel & communication
├── go.mod
├── go.sum
├── main.go                 # Application entry point
└── README.md
```


# kprm-go
