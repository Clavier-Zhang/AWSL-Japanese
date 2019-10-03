package utils

import (
	"encoding/json"
	"net/http"
	"github.com/google/uuid"
)

func Message(status bool, message string) (map[string]interface{}) {
	return map[string]interface{} {"status" : status, "message" : message}
}

func Respond(w http.ResponseWriter, data map[string] interface{})  {
	w.Header().Add("Content-Type", "application/json")
json.NewEncoder(w).Encode(data)
}

// Generate random UUID
func NewUUID() string {
	return uuid.New().String()
}

