package database

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"kprm2/config"
)

var DB *sql.DB

func InitDB(cfg *config.Config) (*sql.DB, error) {
	// DSN format: username:password@tcp(host:port)/dbname?parseTime=true&loc=Asia%2FKolkata&charset=utf8mb4
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true&loc=Asia%%2FKolkata&charset=utf8mb4&collation=utf8mb4_unicode_ci",
		cfg.DBUser,
		cfg.DBPass,
		cfg.DBHost,
		cfg.DBPort,
		cfg.DBName,
	)

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
	}

	DB = db
	return db, nil
}

func GetDB() *sql.DB {
	return DB
}

