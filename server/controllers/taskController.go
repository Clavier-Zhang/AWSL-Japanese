package controllers

import (
	"github.com/gorilla/mux"
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
	task := FindTaskByEmailAndDate(email, report.Date)
	session := FindSessionByEmail(email)

	// Update task
	ok := task.HandleReport(*report)
	if !ok {
		result := Message(false, "Report does not match task")
		Respond(w, result, "TaskSubmitController: Report does not match task")
		return
	}

	// Update session
	for id, record := range task.Records {
		card := session.Cards[id]
		card.ReceiveResponseQuality(record.ReviewCount, task.Date)
		session.Cards[id] = card
	}

	// Save session and task
	session.Save()
	task.Save()

	result := Message(true, "Submit task")
	Respond(w, result, "TaskSubmitController: Success, "+email)
}