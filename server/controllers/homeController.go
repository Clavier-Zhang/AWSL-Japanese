package controllers

import (
	"fmt"
	"log"
	"net/http"
	. "server/models/plan"
	. "server/models/session"
	. "server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {

	email := r.Context().Value("email").(string)
	log.Println("HomeController ", email)

	session := FindSessionByEmail(email)
	if session == nil {
		fmt.Println("Session not exist, create a new one")
		session = NewSession(email)
		session.Save()
	}

	plan := FindPlanByName(session.CurrentPlan)

	if plan == nil {
		result := Message(false, "Plan "+session.CurrentPlan+" not exist")
		Respond(w, result)
		return
	}

	if session == nil {
		result := Message(false, "Session not exist")
		Respond(w, result)
		return
	}

	result := Message(true, "Home data")
	result["finishedWordCount"] = session.GetFinishedWordCount()
	result["progressingWordCount"] = session.GetProgressingWordCount()
	result["currentPlan"] = session.CurrentPlan
	result["currentPlanLeftWordCount"] = len(Union(plan.WordIDs, session.GetWordIDs()))

	Respond(w, result)
}