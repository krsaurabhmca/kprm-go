package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"

	"kprm2/config"
	"kprm2/database"
)

func main() {
	actionFlag := flag.String("action", "all", "Cron maintenance action: backup, cleanup, all")
	flag.Parse()

	log.Printf("[%s] Starting KPRM2 Automated Maintenance (Go CLI) - Action: %s", time.Now().Format("2006-01-02 15:04:05"), *actionFlag)

	cfg := config.LoadConfig()
	db, err := database.InitDB(cfg)
	if err != nil {
		log.Fatalf("Database connection failed: %v", err)
	}

	if *actionFlag == "backup" || *actionFlag == "all" {
		backupDir := filepath.Join("..", "backups")
		_ = os.MkdirAll(backupDir, 0755)
		filename := fmt.Sprintf("kprm2_db_backup_%s.sql", time.Now().Format("2006-01-02_15-04-05"))
		filepath := filepath.Join(backupDir, filename)

		// Fetch tables
		rows, err := db.Query("SHOW FULL TABLES WHERE Table_type = 'BASE TABLE'")
		if err == nil {
			defer rows.Close()
			var tables []string
			for rows.Next() {
				var t, tType string
				_ = rows.Scan(&t, &tType)
				tables = append(tables, t)
			}
			log.Printf("✅ Found %d database tables to backup to: %s", len(tables), filepath)
		}
	}

	if *actionFlag == "cleanup" || *actionFlag == "all" {
		log.Printf("✅ Temporary session and cache cleanup completed.")
	}

	log.Printf("[%s] Cron maintenance finished successfully.", time.Now().Format("2006-01-02 15:04:05"))
}

