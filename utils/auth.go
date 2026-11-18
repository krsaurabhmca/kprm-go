package utils

import (
	"strings"

	"golang.org/x/crypto/bcrypt"
)

// CheckPassword verifies password against PHP or Go bcrypt hash
func CheckPassword(password, hash string) bool {
	// PHP bcrypt generates prefix $2y$, convert to $2a$ for Go standard library compatibility
	standardHash := hash
	if strings.HasPrefix(standardHash, "$2y$") {
		standardHash = "$2a$" + standardHash[4:]
	}
	err := bcrypt.CompareHashAndPassword([]byte(standardHash), []byte(password))
	return err == nil
}

// HashPassword creates standard bcrypt hash
func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 12)
	if err != nil {
		return "", err
	}
	// Prefix with $2y$ for complete two-way compatibility with PHP's password_verify()
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

