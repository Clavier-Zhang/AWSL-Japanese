package controllers

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/models/task"
	. "server/models/word"
	."server/models/plan"
	."server/models/session"
	. "server/utils"
	"strconv"
)

func TaskGetController(w http.ResponseWriter, r *http.Request) {
	// Get request data
	date, _ := strconv.Atoi(mux.Vars(r)["date"])
	email := r.Context().Value("email").(string)
	// Check if task already exist
	task := FindTaskByEmailAndDate(email, date)
	// If task has been created
	if task != nil {
		words := WordIdsToWords(task.GetWordIDs())
		response := Message(true, "Get task by date, task has been created")
		response["words"] = words
		Respond(w, response)
		return
	}
	// else, create new task
	session := FindSessionByEmail(email)
	plan := FindPlanByName(session.CurrentPlan)

	task = NewTask(session, plan, date)
	task.Save()


	response := Message(true, "Get task by date")
	words := WordIdsToWords(task.GetWordIDs())


	response["words"] = words
	Respond(w, response)
}


func TaskSubmitController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	task := DecodeTask(r.Body)
	println(task)

	result := Message(true, "Submit task")

	log.Println("TaskGetController ","email:", email, " date: ", "123")

	//log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result)
}