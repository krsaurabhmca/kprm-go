package utils

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/smtp"
	"strings"
	"time"
)

// GreenAPIConfig configuration options
type GreenAPIConfig struct {
	InstanceID string `json:"green_api_instance"`
	APIToken   string `json:"green_api_token"`
	BaseURL    string `json:"green_api_url"`
}

// MaskPhoneNumber masks middle digits e.g. 919876543210 -> 919876XXXX10
func MaskPhoneNumber(phone string) string {
	clean := strings.TrimSpace(phone)
	clean = strings.ReplaceAll(clean, "@c.us", "")
	clean = strings.ReplaceAll(clean, "@g.us", "")
	if len(clean) < 8 {
		return clean
	}
	prefix := clean[:5]
	suffix := clean[len(clean)-2:]
	return prefix + "XXXX" + suffix
}

// FormatWhatsAppChatID ensures @c.us or @g.us suffix
func FormatWhatsAppChatID(recipient string) string {
	r := strings.TrimSpace(recipient)
	if strings.Contains(r, "@") {
		return r
	}
	// If 18+ digits or contains hyphen, usually a WhatsApp group
	if len(r) >= 18 || strings.Contains(r, "-") {
		return r + "@g.us"
	}
	return r + "@c.us"
}

// SendGreenAPIText dispatches text message via Green API
func SendGreenAPIText(cfg GreenAPIConfig, phone, message string) (map[string]interface{}, error) {
	baseURL := strings.TrimRight(cfg.BaseURL, "/")
	if baseURL == "" {
		baseURL = "https://api.green-api.com"
	}

	url := fmt.Sprintf("%s/waInstance%s/sendMessage/%s", baseURL, cfg.InstanceID, cfg.APIToken)
	chatID := FormatWhatsAppChatID(phone)

	payload := map[string]string{
		"chatId":  chatID,
		"message": message,
	}
	body, _ := json.Marshal(payload)

	client := &http.Client{Timeout: 15 * time.Second}
	resp, err := client.Post(url, "application/json", bytes.NewBuffer(body))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result map[string]interface{}
	_ = json.NewDecoder(resp.Body).Decode(&result)
	return result, nil
}

// SendGreenAPIFile sends media/document file
func SendGreenAPIFile(cfg GreenAPIConfig, phone, fileURL, fileName, caption string) (map[string]interface{}, error) {
	baseURL := strings.TrimRight(cfg.BaseURL, "/")
	if baseURL == "" {
		baseURL = "https://api.green-api.com"
	}

	url := fmt.Sprintf("%s/waInstance%s/sendFileByUrl/%s", baseURL, cfg.InstanceID, cfg.APIToken)
	chatID := FormatWhatsAppChatID(phone)

	payload := map[string]string{
		"chatId":   chatID,
		"urlFile":  fileURL,
		"fileName": fileName,
		"caption":  caption,
	}
	body, _ := json.Marshal(payload)

	client := &http.Client{Timeout: 30 * time.Second}
	resp, err := client.Post(url, "application/json", bytes.NewBuffer(body))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var result map[string]interface{}
	_ = json.NewDecoder(resp.Body).Decode(&result)
	return result, nil
}

// GreenAPIGetState checks connection state (/getStateInstance)
func GreenAPIGetState(cfg GreenAPIConfig) (string, error) {
	baseURL := strings.TrimRight(cfg.BaseURL, "/")
	if baseURL == "" {
		baseURL = "https://api.green-api.com"
	}

	url := fmt.Sprintf("%s/waInstance%s/getStateInstance/%s", baseURL, cfg.InstanceID, cfg.APIToken)
	client := &http.Client{Timeout: 10 * time.Second}
	resp, err := client.Get(url)
	if err != nil {
		return "offline", err
	}
	defer resp.Body.Close()

	var res struct {
		StateInstance string `json:"stateInstance"`
	}
	_ = json.NewDecoder(resp.Body).Decode(&res)
	if res.StateInstance != "" {
		return res.StateInstance, nil
	}
	return "unknown", nil
}

// GreenAPIGetQRCode fetches live QR code for authentication
func GreenAPIGetQRCode(cfg GreenAPIConfig) (string, error) {
	baseURL := strings.TrimRight(cfg.BaseURL, "/")
	if baseURL == "" {
		baseURL = "https://api.green-api.com"
	}

	url := fmt.Sprintf("%s/waInstance%s/qr/%s", baseURL, cfg.InstanceID, cfg.APIToken)
	client := &http.Client{Timeout: 10 * time.Second}
	resp, err := client.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, _ := io.ReadAll(resp.Body)
	var res struct {
		Type    string `json:"type"`
		Message string `json:"message"`
	}
	_ = json.Unmarshal(body, &res)
	return res.Message, nil
}

// SMTPConfig configuration options
type SMTPConfig struct {
	Host       string `json:"smtp_host"`
	Port       string `json:"smtp_port"`
	Username   string `json:"smtp_username"`
	Password   string `json:"smtp_password"`
	FromEmail  string `json:"smtp_from_email"`
	FromName   string `json:"smtp_from_name"`
	Encryption string `json:"smtp_encryption"` // 'tls', 'ssl', or 'none'
}

// SendSMTPEmail sends HTML email message
func SendSMTPEmail(cfg SMTPConfig, toEmail, subject, bodyHTML string) error {
	addr := fmt.Sprintf("%s:%s", cfg.Host, cfg.Port)
	auth := smtp.PlainAuth("", cfg.Username, cfg.Password, cfg.Host)

	fromHeader := fmt.Sprintf("%s <%s>", cfg.FromName, cfg.FromEmail)
	headers := make(map[string]string)
	headers["From"] = fromHeader
	headers["To"] = toEmail
	headers["Subject"] = subject
	headers["MIME-Version"] = "1.0"
	headers["Content-Type"] = "text/html; charset=UTF-8"

	message := ""
	for k, v := range headers {
		message += fmt.Sprintf("%s: %s\r\n", k, v)
	}
	message += "\r\n" + bodyHTML

	return smtp.SendMail(addr, auth, cfg.FromEmail, []string{toEmail}, []byte(message))
}

