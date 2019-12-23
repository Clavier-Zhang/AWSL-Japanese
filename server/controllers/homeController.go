package controllers

import (
	"net/http"
	. "server/models/plan"
	. "server/models/session"
	. "server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {
	// Get parameter
	email := r.Context().Value("email").(string)
	// Find session
	session := FindSessionByEmail(email)

	// If session not exists
	if session == nil {
		session = NewSession(email)
		session.Save()
	}

	// Find plan
	plan := FindPlanByName(session.CurrentPlan)

	if plan == nil {
		result := Message(false, "BUG: Plan "+session.CurrentPlan+" not exist")
		Respond(w, result, "", email)
		return
	}

	// Response
	result := Message(true, "Get home data")
	result["finishedWordCount"] = session.GetFinishedWordCount()
	result["progressingWordCount"] = session.GetProgressingWordCount()
	result["currentPlan"] = session.CurrentPlan
	result["currentPlanLeftWordCount"] = len(session.GetNewWordIdsFromPlan(plan))
	result["scheduledWordsCount"] = session.ScheduledWordCount
	Respond(w, result, "HomeController", email)
}