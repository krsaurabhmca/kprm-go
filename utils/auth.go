package utils

import (
	"crypto/md5"
	"fmt"
	"strings"

	"golang.org/x/crypto/bcrypt"
)

// CheckPassword verifies password against PHP or Go bcrypt hash, legacy MD5, or plain text
func CheckPassword(password, hash string) bool {
	if password == "" || hash == "" {
		return false
	}

	// 1. Direct match (plain text fallback)
	if password == hash {
		return true
	}

	// 2. Legacy MD5 fallback (if any legacy user hash is 32-char hex)
	if len(hash) == 32 {
		md5Hash := fmt.Sprintf("%x", md5.Sum([]byte(password)))
		if strings.EqualFold(md5Hash, hash) {
			return true
		}
	}

	// 3. Bcrypt ($2y$, $2b$, or $2a$)
	standardHash := hash
	if strings.HasPrefix(standardHash, "$2y$") || strings.HasPrefix(standardHash, "$2b$") {
		standardHash = "$2a$" + standardHash[4:]
	}
	err := bcrypt.CompareHashAndPassword([]byte(standardHash), []byte(password))
	return err == nil
}

// HashPassword creates standard bcrypt hash with $2y$ prefix for two-way PHP compatibility
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 12)
	if err != nil {
		return "", err
	}
	hashStr := string(bytes)
	if strings.HasPrefix(hashStr, "$2a$") {
		hashStr = "$2y$" + hashStr[4:]
	}
	return hashStr, nil
}

// CurrentUserHasRole checks if the user's role matches any allowed role
// DEV role always matches everything (root access)
func CurrentUserHasRole(userRole string, allowedRoles []string) bool {
	if strings.EqualFold(userRole, "DEV") {
		return true
	}
	for _, r := range allowedRoles {
		if strings.EqualFold(strings.TrimSpace(r), strings.TrimSpace(userRole)) {
			return true
		}
	}
	return false
}
