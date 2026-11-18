package config

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
)

type Config struct {
	AppEnv     string
	AppURL     string
	Port       string
	DBHost     string
	DBPort     string
	DBUser     string
	DBPass     string
	DBName     string
	UploadPath string
	SecretKey  string
}

var AppConfig *Config

func LoadConfig() *Config {
	// Search for .env file in parent dir or current dir
	envPaths := []string{
		".env",
		"../.env",
		filepath.Join(os.Getenv("KPRM_ROOT"), ".env"),
	}

	for _, p := range envPaths {
		if p != "" {
			if _, err := os.Stat(p); err == nil {
				_ = godotenv.Load(p)
				break
			}
		}
	}

	port := getEnv("PORT", "8080")
	dbHost := getEnv("DB_HOST", "localhost")
	dbPort := getEnv("DB_PORT", "3306")
	dbUser := getEnv("DB_USER", "root")
	dbPass := getEnv("DB_PASS", "")
	dbName := getEnv("DB_NAME", "kprm2_db")
	appEnv := getEnv("APP_ENV", "development")
	appURL := getEnv("APP_URL", fmt.Sprintf("http://localhost:%s", port))

	// By default, share uploads directory with existing PHP application if possible
	uploadPath := getEnv("UPLOAD_PATH", "")
	if uploadPath == "" {
		if _, err := os.Stat("../uploads"); err == nil {
			uploadPath = "../uploads"
		} else {
			uploadPath = "./uploads"
		}
	}

	AppConfig = &Config{
		AppEnv:     appEnv,
		AppURL:     appURL,
		Port:       port,
		DBHost:     dbHost,
		DBPort:     dbPort,
		DBUser:     dbUser,
		DBPass:     dbPass,
		DBName:     dbName,
		UploadPath: uploadPath,
		SecretKey:  getEnv("SESSION_SECRET", "kprm2_secret_session_key_random_64_bytes_secure"),
	}

	return AppConfig
}

func getEnv(key, defaultVal string) string {
	if val := os.Getenv(key); val != "" {
		return val
	}
	return defaultVal
}

