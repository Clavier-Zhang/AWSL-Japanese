package controllers

import (
	//"bytes"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/models"
	. "server/utils"
)

func TaskGetController(w http.ResponseWriter, r *http.Request) {
	// Get request data
	date := mux.Vars(r)["date"]
	email := r.Context().Value("email").(string)

	//user := FindByEmail(email)



	result := Message(true, "Get task by date")


	words := *FindAllLimit()
	result["words"] = words

	log.Println("TaskGetController ","email:", email, " date:", date)

	Respond(w, result)
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