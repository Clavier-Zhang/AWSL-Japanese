package controllers

import (
	"log"
	"net/http"
	. "server/utils"
	."server/models"
)

func HomeController(w http.ResponseWriter, r *http.Request) {

	email := r.Context().Value("email").(string)
	log.Println("HomeController ", email)

	session := FindSessionByEmail(email)
	if session == nil {
		_ = PrettyPrint("Session not exist, create a new one")
		session = NewSession(email)
	}
	session = NewSession(email)

	plan := NewPlan("N3", "zzzzz")


	words := FindAllLimit()
	for i := 0; i < len(*words); i++ {
		plan.WordIDs = append(plan.WordIDs, (*words)[i].ID)
	}

	PrettyPrint(plan)
	plan.Save()



	result := Message(true, "home")

	result["finishedNum"] = session.FinishedWordCount
	result["progressingNum"] = session.ProgressingWordCount
	result["currentBook"] = session.CurrentPlan
	result["todayNewNum"] = 78
	result["todayScheduleNum"] = session.ScheduledWordCount

	_ = PrettyPrint(result)

	Respond(w, result)
}