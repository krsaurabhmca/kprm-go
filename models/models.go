package models

import (
	"database/sql"
	"time"
)

// User represents a system user
type User struct {
	ID               int            `json:"id" db:"id"`
	Username         string         `json:"username" db:"username"`
	PasswordHash     string         `json:"-" db:"password_hash"`
	RoleID           int            `json:"role_id" db:"role_id"`
	RoleName         string         `json:"role_name" db:"role_name"`
	Email            sql.NullString `json:"email" db:"email"`
	Mobile           sql.NullString `json:"mobile" db:"mobile"`
	AllowedTaskTypes sql.NullString `json:"allowed_task_types" db:"allowed_task_types"`
	CreatedAt        time.Time      `json:"created_at" db:"created_at"`
}

// UserRole represents RBAC roles: Admin, DEV, Manager, BEO, Verifier, Reviewer
type UserRole struct {
	ID       int    `json:"id" db:"id"`
	RoleName string `json:"role_name" db:"role_name"`
}

// Client represents a corporate/bank client
type Client struct {
	ID                     int            `json:"id" db:"id"`
	Name                   string         `json:"name" db:"name"`
	StampImage             sql.NullString `json:"stamp_image" db:"stamp_image"`
	EmailReportingEnabled  int            `json:"email_reporting_enabled" db:"email_reporting_enabled"`
	CreatedAt              time.Time      `json:"created_at" db:"created_at"`
}

// ClientStructure represents dynamic form blueprint for a client
type ClientStructure struct {
	ID            int       `json:"id" db:"id"`
	ClientID      int       `json:"client_id" db:"client_id"`
	ClientName    string    `json:"client_name" db:"client_name"`
	StructureName string    `json:"structure_name" db:"structure_name"`
	CreatedAt     time.Time `json:"created_at" db:"created_at"`
}

// StructureColumn represents columns in client_structure
type StructureColumn struct {
	ID                 int            `json:"id" db:"id"`
	StructureID        int            `json:"structure_id" db:"structure_id"`
	ColumnName         string         `json:"column_name" db:"column_name"`
	DisplayName        string         `json:"display_name" db:"display_name"`
	DataType           string         `json:"data_type" db:"data_type"`
	IsMandatory        int            `json:"is_mandatory" db:"is_mandatory"`
	DropdownOptions    sql.NullString `json:"dropdown_options" db:"dropdown_options"`
	CalculatedFormula  sql.NullString `json:"calculated_formula" db:"calculated_formula"`
	CalculatedFunction sql.NullString `json:"calculated_function" db:"calculated_function"`
	OrderIndex         int            `json:"order_index" db:"order_index"`
}

// ColumnRBAC represents permission for structure column by role
type ColumnRBAC struct {
	ID         int    `json:"id" db:"id"`
	ColumnID   int    `json:"column_id" db:"column_id"`
	RoleID     int    `json:"role_id" db:"role_id"`
	Visibility string `json:"visibility" db:"visibility"` // 'hidden', 'readonly', 'editable'
}

// Case represents a verification case
type Case struct {
	ID            int            `json:"id" db:"id"`
	ClientID      int            `json:"client_id" db:"client_id"`
	ClientName    string         `json:"client_name" db:"client_name"`
	StructureID   int            `json:"structure_id" db:"structure_id"`
	StructureName string         `json:"structure_name" db:"structure_name"`
	CreatedBy     int            `json:"created_by" db:"created_by"`
	CreatedByName string         `json:"created_by_name" db:"created_by_name"`
	OverallStatus string         `json:"overall_status" db:"overall_status"`
	IsClosed      int            `json:"is_closed" db:"is_closed"`
	PickupDate    sql.NullTime   `json:"pickup_date" db:"pickup_date"`
	RevertedDate  sql.NullTime   `json:"reverted_date" db:"reverted_date"`
	CreatedAt     time.Time      `json:"created_at" db:"created_at"`
	UpdatedAt     sql.NullTime   `json:"updated_at" db:"updated_at"`

	// Dynamic values loaded on demand
	DynamicData   map[string]string `json:"dynamic_data"`
	TaskCount     int               `json:"task_count"`
	CompletedCount int              `json:"completed_count"`
}

// CaseData holds EAV column value for case
type CaseData struct {
	ID          int            `json:"id" db:"id"`
	CaseID      int            `json:"case_id" db:"case_id"`
	ColumnID    int            `json:"column_id" db:"column_id"`
	DataValue   sql.NullString `json:"data_value" db:"data_value"`
	ColumnName  string         `json:"column_name" db:"column_name"`
	DisplayName string         `json:"display_name" db:"display_name"`
}

// Task represents a blueprint task definition
type Task struct {
	ID          int            `json:"id" db:"id"`
	TaskName    string         `json:"task_name" db:"task_name"`
	TaskType    string         `json:"task_type" db:"task_type"` // e.g. PHYSICAL, ITR, BANKING, ALL
	Description sql.NullString `json:"description" db:"description"`
	CreatedAt   time.Time      `json:"created_at" db:"created_at"`
}

// CaseTask represents a task assigned to a case
type CaseTask struct {
	ID             int            `json:"id" db:"id"`
	CaseID         int            `json:"case_id" db:"case_id"`
	TaskID         int            `json:"task_id" db:"task_id"`
	TaskName       string         `json:"task_name" db:"task_name"`
	TaskType       string         `json:"task_type" db:"task_type"`
	AssignedTo     sql.NullInt64  `json:"assigned_to" db:"assigned_to"`
	AssignedToName string         `json:"assigned_to_name" db:"assigned_to_name"`
	Status         string         `json:"status" db:"status"` // 'Pending', 'In Progress', 'Review Pending', 'Positive', 'Negative', 'CNV'
	Remarks        sql.NullString `json:"remarks" db:"remarks"`
	VerifiedAt     sql.NullTime   `json:"verified_at" db:"verified_at"`
	CreatedAt      time.Time      `json:"created_at" db:"created_at"`
	ExternalTaskID sql.NullString `json:"external_task_id" db:"external_task_id"`
	ExternalStatus sql.NullString `json:"external_status" db:"external_status"`
	ExternalSyncAt sql.NullTime   `json:"external_sync_at" db:"external_sync_at"`
	FinancialTable sql.NullString `json:"financial_table" db:"financial_table"`

	// Extra loaded data
	ClientName  string            `json:"client_name"`
	MetaValues  map[string]string `json:"meta_values"`
	Attachments []string          `json:"attachments"`
}

// CaseTaskData holds EAV meta values for case task
type CaseTaskData struct {
	ID          int            `json:"id" db:"id"`
	CaseTaskID  int            `json:"case_task_id" db:"case_task_id"`
	TaskMetaID  int            `json:"task_meta_id" db:"task_meta_id"`
	DataValue   sql.NullString `json:"data_value" db:"data_value"`
	MetaKey     string         `json:"meta_key" db:"meta_key"`
	DisplayName string         `json:"display_name" db:"display_name"`
}

// TaskMeta represents configurable meta fields for a task
type TaskMeta struct {
	ID          int            `json:"id" db:"id"`
	TaskID      int            `json:"task_id" db:"task_id"`
	MetaKey     string         `json:"meta_key" db:"meta_key"`
	DisplayName string         `json:"display_name" db:"display_name"`
	DataType    string         `json:"data_type" db:"data_type"` // 'text', 'textarea', 'dropdown', 'date', 'file', 'financial_grid'
	IsRequired  int            `json:"is_required" db:"is_required"`
	Options     sql.NullString `json:"options" db:"options"`
	OrderIndex  int            `json:"order_index" db:"order_index"`
}

// TaskMetaRBAC represents role-based field visibility
type TaskMetaRBAC struct {
	ID         int    `json:"id" db:"id"`
	TaskMetaID int    `json:"task_meta_id" db:"task_meta_id"`
	RoleID     int    `json:"role_id" db:"role_id"`
	Visibility string `json:"visibility" db:"visibility"` // 'hidden', 'readonly', 'editable'
}

// TaskRemarks holds standard remarks templates
type TaskRemarks struct {
	ID             int    `json:"id" db:"id"`
	TaskID         int    `json:"task_id" db:"task_id"`
	Status         string `json:"status" db:"status"` // 'Positive', 'Negative', 'CNV'
	RemarkTemplate string `json:"remark_template" db:"remark_template"`
}

// TaskReportFormat config for report formatters
type TaskReportFormat struct {
	ID           int            `json:"id" db:"id"`
	Name         string         `json:"name" db:"name"`
	Slug         sql.NullString `json:"slug" db:"slug"`
	Description  sql.NullString `json:"description" db:"description"`
	ColumnsJSON  string         `json:"columns_json" db:"columns_json"`
	OptionsJSON  sql.NullString `json:"options_json" db:"options_json"`
	ExtraMessage sql.NullString `json:"extra_message" db:"extra_message"`
	IsSystem     int            `json:"is_system" db:"is_system"`
}

// CommunicationAccount stores GreenAPI / SMTP accounts
type CommunicationAccount struct {
	ID          int            `json:"id" db:"id"`
	Channel     string         `json:"channel" db:"channel"` // 'whatsapp', 'smtp'
	AccountName string         `json:"account_name" db:"account_name"`
	ConfigJSON  string         `json:"config_json" db:"config_json"`
	IsDefault   int            `json:"is_default" db:"is_default"`
	Status      string         `json:"status" db:"status"`
	CreatedAt   time.Time      `json:"created_at" db:"created_at"`
}

// CommunicationTemplate holds template messages with tags
type CommunicationTemplate struct {
	ID        int            `json:"id" db:"id"`
	EventName string         `json:"event_name" db:"event_name"` // 'on_task_assigned', 'on_case_reviewed'
	Channel   string         `json:"channel" db:"channel"`
	Subject   sql.NullString `json:"subject" db:"subject"`
	Body      string         `json:"body" db:"body"`
	IsActive  int            `json:"is_active" db:"is_active"`
}

// TaskTypeCommunication assigns accounts to task types
type TaskTypeCommunication struct {
	ID         int    `json:"id" db:"id"`
	TaskType   string `json:"task_type" db:"task_type"`
	Status     string `json:"status" db:"status"`
	SmtpID     int    `json:"smtp_id" db:"smtp_id"`
	WhatsappID int    `json:"whatsapp_id" db:"whatsapp_id"`
}

// SystemSetting key-value configuration
type SystemSetting struct {
	ID           int    `json:"id" db:"id"`
	SettingKey   string `json:"setting_key" db:"setting_key"`
	SettingValue string `json:"setting_value" db:"setting_value"`
}

// CaseTaskHistory log entry
type CaseTaskHistory struct {
	ID         int            `json:"id" db:"id"`
	CaseTaskID int            `json:"case_task_id" db:"case_task_id"`
	Status     string         `json:"status" db:"status"`
	Remark     sql.NullString `json:"remark" db:"remark"`
	CreatedBy  sql.NullInt64  `json:"created_by" db:"created_by"`
	CreatedAt  time.Time      `json:"created_at" db:"created_at"`
}

