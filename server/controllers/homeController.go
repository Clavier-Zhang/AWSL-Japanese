package controllers

import (
	"log"
	"net/http"
	. "server/models/plan"
	session2 "server/models/session"
	. "server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {

	email := r.Context().Value("email").(string)
	log.Println("HomeController ", email)

	session := session2.FindSessionByEmail(email)
	if session == nil {
		log.Println("Session not exist, create a new one")
		session = session2.NewSession(email)
		session.Save()
	}

	plan := FindPlanByName(session.CurrentPlan)

	PrettyPrint(plan)
	PrettyPrint(session)

	result := Message(true, "home")
	result["finishedWordCount"] = session.GetFinishedWordCount()
	result["progressingWordCount"] = session.GetprogressingWordCount()
	result["currentPlan"] = session.CurrentPlan
	result["currentPlanLeftWordCount"] = 54

	_ = PrettyPrint(result)

	Respond(w, result)
}