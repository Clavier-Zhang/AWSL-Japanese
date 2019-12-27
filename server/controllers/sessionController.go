package controllers

import (
	"net/http"
	. "server/models/session"
	"server/utils"
)



func SessionUpdateController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	data := utils.DecodeToMap(r.Body)
	session := FindSessionByEmail(email)

	// Update session
	session.ScheduledWordCount = int(data["num"].(float64))
	session.CurrentPlan = data["plan"].(string)
	session.Save()

	result := utils.Message(true, "Update session")
	utils.Respond(w, result, "SessionUpdateController", email)
}
