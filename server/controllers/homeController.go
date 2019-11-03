package controllers

import (
	"log"
	"net/http"
	. "server/models/plan"
	. "server/models/session"
	"server/models/word"
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
	words := word.FindAllWordsByIDs(session.GetWordIDs())
	PrettyPrint(session.GetWordIDs())
	PrettyPrint(words)

	result := Message(true, "Home data")
	result["finishedWordCount"] = session.GetFinishedWordCount()
	result["progressingWordCount"] = session.GetProgressingWordCount()
	result["currentPlan"] = session.CurrentPlan
	result["currentPlanLeftWordCount"] = len(Union(plan.WordIDs, session.GetWordIDs()))

	_ = PrettyPrint(result)

	Respond(w, result)
}