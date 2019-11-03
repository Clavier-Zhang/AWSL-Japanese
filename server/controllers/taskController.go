package controllers

import (
	//"bytes"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/models"
	. "server/models/plan"
	. "server/models/session"
	task2 "server/models/task"
	. "server/utils"
)

func TaskGetController(w http.ResponseWriter, r *http.Request) {
	// Get request data
	date := mux.Vars(r)["date"]
	email := r.Context().Value("email").(string)

	// Check if task already exist

	// Get DB data
	session := FindSessionByEmail(email)
	plan := FindPlanByName(session.CurrentPlan)
	PrettyPrint(plan)



	result := Message(true, "Get task by date")


	words := *FindAllLimit()
	result["words"] = words

	log.Println("TaskGetController ","email:", email, " date:", date)

	Respond(w, result)
}


func TaskSubmitController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	task := task2.DecodeTask(r.Body)
	println(task)

	result := Message(true, "Submit task")

	log.Println("TaskGetController ","email:", email, " date: ", "123")

	//log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result)
}