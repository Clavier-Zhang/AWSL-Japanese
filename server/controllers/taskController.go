package controllers

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/models/plan"
	. "server/models/session"
	. "server/models/task"
	. "server/models/word"
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
		response["newWordsCount"] = task.NewWordsCount
		response["words"] = words
		Respond(w, response, "TaskGetController: task has been created")
		return
	}
	// else, create new task
	session := FindSessionByEmail(email)
	plan := FindPlanByName(session.CurrentPlan)

	task = NewTask(session, plan, date)
	task.Save()


	response := Message(true, "Get task by date")
	words := WordIdsToWords(task.GetWordIDs())

	response["newWordsCount"] = task.NewWordsCount
	response["words"] = words
	Respond(w, response, "TaskGetController: Create new task")

}


func TaskSubmitController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	report := DecodeReport(r.Body)
	log.Println("print report")
	PrettyPrint(*report)

	//println(report.Date)

	result := Message(true, "Submit task")

	log.Println("TaskGetController ","email:", email, " date: ", "123")

	//log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result, "TaskSubmitController")
}