package database

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/go-sql-driver/mysql"
	"kprm2/config"
)

var DB *sql.DB

func InitDB(cfg *config.Config) (*sql.DB, error) {
	loc, err := time.LoadLocation("Asia/Kolkata")
	if err != nil {
		loc = time.Local
	}

	mysqlCfg := mysql.NewConfig()
	mysqlCfg.User = cfg.DBUser
	mysqlCfg.Passwd = cfg.DBPass
	mysqlCfg.Net = "tcp"
	mysqlCfg.Addr = fmt.Sprintf("%s:%s", cfg.DBHost, cfg.DBPort)
	mysqlCfg.DBName = cfg.DBName
	mysqlCfg.ParseTime = true
	mysqlCfg.Loc = loc
	mysqlCfg.Collation = "utf8mb4_unicode_ci"
	mysqlCfg.AllowNativePasswords = true

	dsn := mysqlCfg.FormatDSN()

	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, fmt.Errorf("error opening database: %w", err)
	}

	db.SetMaxOpenConns(50)
	db.SetMaxIdleConns(25)
	db.SetConnMaxLifetime(5 * time.Minute)

	// Note: We don't fail immediately on ping so server can start and display a friendly DB message or reconnect if MySQL starts
	if err := db.Ping(); err != nil {
		log.Printf("⚠️ Warning: Initial database ping failed (%v). Ensure MySQL is running on %s:%s.", err, cfg.DBHost, cfg.DBPort)
	} else {
		log.Printf("✅ Connected successfully to MySQL database: %s", cfg.DBName)
		// Ensure Indian Standard Time offset
		_, _ = db.Exec("SET time_zone = '+05:30'")
		// Ensure basic essential auth tables and admin user are present
		ensureEssentialTables(db)
	}

	DB = db
	return db, nil
}

func ensureEssentialTables(db *sql.DB) {
	// 1. Ensure user_roles
	_, _ = db.Exec(`
		CREATE TABLE IF NOT EXISTS user_roles (
			id int NOT NULL AUTO_INCREMENT,
			role_name varchar(50) NOT NULL,
			PRIMARY KEY (id)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
	`)
	_, _ = db.Exec(`
		INSERT IGNORE INTO user_roles (id, role_name) VALUES
		(1, 'Admin'), (2, 'Manager'), (3, 'BEO'), (4, 'Reviewer'), (5, 'Verifier'), (6, 'Client'), (7, 'DEV')
	`)

	// 2. Ensure users
	_, _ = db.Exec(`
		CREATE TABLE IF NOT EXISTS users (
			id int NOT NULL AUTO_INCREMENT,
			username varchar(50) NOT NULL UNIQUE,
			password_hash varchar(255) NOT NULL,
			role_id int DEFAULT 1,
			allowed_task_types varchar(255) DEFAULT NULL,
			created_at timestamp DEFAULT CURRENT_TIMESTAMP,
			email varchar(150) DEFAULT NULL,
			mobile varchar(100) DEFAULT NULL,
			PRIMARY KEY (id)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
	`)

	// 2b. Make sure columns exist even if users table was created from an older schema dump
	_, _ = db.Exec("ALTER TABLE users ADD COLUMN allowed_task_types VARCHAR(255) NULL")
	_, _ = db.Exec("ALTER TABLE users ADD COLUMN email VARCHAR(150) NULL")
	_, _ = db.Exec("ALTER TABLE users ADD COLUMN mobile VARCHAR(100) NULL")

	// 3. Ensure default admin and offerplant users exist if users table is empty
	var userCount int
	_ = db.QueryRow("SELECT COUNT(*) FROM users").Scan(&userCount)
	if userCount == 0 {
		log.Printf("ℹ️ Database has no users: auto-seeding default 'admin' (password: admin123) and 'offerplant'")
		_, _ = db.Exec(`
			INSERT IGNORE INTO users (id, username, password_hash, role_id, email) VALUES
			(1, 'admin', '$2y$12$wHnZJPs2Tal2E2jgs9JMeur.CsDDR8MceNqwAs.pUrKje4hyp9FEC', 1, 'admin@offerplant.com'),
			(2, 'offerplant', '$2y$12$xSyMOQj9lDp6R4b6mvfyVud/kbQ5kzkmAl0NxdG4ycAAvb4rzZg9S', 7, 'myofferplant@gmail.com')
		`)
	}
}

func GetDB() *sql.DB {
	return DB
}
