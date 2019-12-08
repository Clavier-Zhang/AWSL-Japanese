package controllers

import (
	//"io/ioutil"
	"net/http"
	."server/models/session"
	. "server/utils"
)



func SessionUpdateController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	data := DecodeToMap(r.Body)
	session := FindSessionByEmail(email)

	// Update session
	session.ScheduledWordCount = int(data["num"].(float64))
	session.CurrentPlan = data["plan"].(string)
	session.Save()


	result := Message(true, "Update session")
	Respond(w, result, "SessionUpdateController: Success, "+email)
}
