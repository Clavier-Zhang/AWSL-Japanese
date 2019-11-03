package controllers

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/models/plan"
	. "server/models/session"
	. "server/models/task"
	"server/models/word"
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
		wordIDs := task.GetWordIDs()
		words := word.FindAllWordsByIDs(wordIDs)
		response := Message(true, "Get task by date")
		response["words"] = words
		Respond(w, response)
		return
	}

	// Get DB data
	session := FindSessionByEmail(email)
	plan := FindPlanByName(session.CurrentPlan)
	PrettyPrint(plan)



	response := Message(true, "Get task by date")


	words := *word.FindAllLimit()
	response["words"] = words

	log.Println("TaskGetController ","email:", email, " date:", date)

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