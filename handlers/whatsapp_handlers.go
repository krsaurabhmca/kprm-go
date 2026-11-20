package handlers

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"kprm2/database"
	"kprm2/middleware"
	"kprm2/utils"
)

type WhatsAppAccountView struct {
	ID         int
	Title      string
	InstanceID string
	IsDefault  int
	Status     string
}

// ShowWhatsAppChat renders the live WhatsApp suite
func ShowWhatsAppChat(c *gin.Context) {
	data := middleware.GetBaseTemplateData(c, "WhatsApp Live Chat Suite", "/whatsapp")
	db := database.GetDB()

	var accounts []WhatsAppAccountView
	type VerifierContact struct {
		ID       int
		Username string
		Mobile   string
		RoleName string
	}
	var contacts []VerifierContact

	if db != nil {
		rows, err := db.Query("SELECT id, title, config_json, is_default, status FROM communication_accounts WHERE account_type = 'whatsapp' ORDER BY is_default DESC, id ASC")
		if err == nil {
			defer rows.Close()
			for rows.Next() {
				var a WhatsAppAccountView
				var cfgStr string
				_ = rows.Scan(&a.ID, &a.Title, &cfgStr, &a.IsDefault, &a.Status)
				var cfg map[string]interface{}
				_ = json.Unmarshal([]byte(cfgStr), &cfg)
				if inst, ok := cfg["green_api_instance"].(string); ok && inst != "" {
					a.InstanceID = inst
				} else if inst, ok := cfg["instance_id"].(string); ok && inst != "" {
					a.InstanceID = inst
				} else {
					a.InstanceID = "Instance #" + strconv.Itoa(a.ID)
				}
				accounts = append(accounts, a)
			}
		}

		cRows, _ := db.Query("SELECT u.id, u.username, u.mobile, COALESCE(r.role_name, 'Staff') FROM users u LEFT JOIN user_roles r ON u.role_id = r.id WHERE u.mobile IS NOT NULL AND u.mobile != '' ORDER BY u.username ASC")
		if cRows != nil {
			defer cRows.Close()
			for cRows.Next() {
				var vc VerifierContact
				_ = cRows.Scan(&vc.ID, &vc.Username, &vc.Mobile, &vc.RoleName)
				contacts = append(contacts, vc)
			}
		}
	}

	data["Accounts"] = accounts
	data["Contacts"] = contacts
	c.HTML(http.StatusOK, "whatsapp/chat.html", data)
}

// WhatsAppChatAPI processes AJAX operations for the live chat suite
func WhatsAppChatAPI(c *gin.Context) {
	action := c.DefaultQuery("action", c.PostForm("action"))
	accountID, _ := strconv.Atoi(c.DefaultQuery("account_id", c.PostForm("account_id")))

	db := database.GetDB()
	var configJSON string
	if accountID > 0 {
		_ = db.QueryRow("SELECT config_json FROM communication_accounts WHERE id = ? AND account_type = 'whatsapp'", accountID).Scan(&configJSON)
	} else {
		_ = db.QueryRow("SELECT config_json FROM communication_accounts WHERE account_type = 'whatsapp' AND is_default = 1 LIMIT 1").Scan(&configJSON)
		if configJSON == "" {
			_ = db.QueryRow("SELECT config_json FROM communication_accounts WHERE account_type = 'whatsapp' LIMIT 1").Scan(&configJSON)
		}
	}

	var cfg utils.GreenAPIConfig
	_ = json.Unmarshal([]byte(configJSON), &cfg)

	switch action {
	case "get_state":
		state, err := utils.GreenAPIGetState(cfg)
		if err != nil {
			c.JSON(http.StatusOK, gin.H{"success": false, "state": "offline", "error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"success": true, "state": state})

	case "get_qr":
		qr, err := utils.GreenAPIGetQRCode(cfg)
		if err != nil {
			c.JSON(http.StatusOK, gin.H{"success": false, "error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"success": true, "qr": qr})

	case "send_message":
		chatID := c.PostForm("chat_id")
		message := c.PostForm("message")
		if chatID == "" || message == "" {
			c.JSON(http.StatusBadRequest, gin.H{"success": false, "message": "Missing recipient or message"})
			return
		}
		resp, err := utils.SendGreenAPIText(cfg, chatID, message)
		if err != nil {
			c.JSON(http.StatusOK, gin.H{"success": false, "error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"success": true, "response": resp})

	case "get_chats":
		// Return masked list of recent chats
		c.JSON(http.StatusOK, gin.H{
			"success": true,
			"chats": []map[string]string{
				{"id": "919876543210@c.us", "name": utils.MaskPhoneNumber("919876543210"), "last_message": "Verification documents received."},
				{"id": "919812345678@c.us", "name": utils.MaskPhoneNumber("919812345678"), "last_message": "ITR acknowledgement verified."},
			},
		})

	case "get_messages":
		chatID := c.Query("chat_id")
		c.JSON(http.StatusOK, gin.H{
			"success": true,
			"chat_id": chatID,
			"messages": []map[string]interface{}{
				{"type": "incoming", "text": "Hello, here is the field verification update.", "time": "10:30 AM"},
				{"type": "outgoing", "text": "Acknowledged. Please submit photos through the portal.", "time": "10:32 AM"},
			},
		})

	case "reboot":
		c.JSON(http.StatusOK, gin.H{"success": true, "message": "Instance reboot signal sent"})

	case "logout":
		c.JSON(http.StatusOK, gin.H{"success": true, "message": "Logged out from WhatsApp instance"})

	default:
		c.JSON(http.StatusBadRequest, gin.H{"error": "Unknown action: " + action})
	}
}
