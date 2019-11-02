package controllers

import (
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
		log.Println("Session not exist, create a new one")
		session = NewSession(email)
		session.Save()
	}

	plan := FindPlanByName(session.CurrentPlan)

	result := Message(true, "Home data")
	result["finishedWordCount"] = session.GetFinishedWordCount()
	result["progressingWordCount"] = session.GetProgressingWordCount()
	result["currentPlan"] = session.CurrentPlan
	result["currentPlanLeftWordCount"] = len(Union(plan.WordIDs, session.GetWordIDs()))

	_ = PrettyPrint(result)

	Respond(w, result)
}