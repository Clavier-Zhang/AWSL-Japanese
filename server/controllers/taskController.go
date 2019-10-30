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
	vars := mux.Vars(r)

	email := r.Context().Value("email").(string)


	result := Message(true, "Get task by date")


	words := *FindAllLimit()
	result["words"] = words

	log.Println("TaskGetController ","email:", email, " date:", vars["date"])

	Respond(w, result)
}


func TaskSubmitController(w http.ResponseWriter, r *http.Request) {

	email := r.Context().Value("email").(string)

	log.Println("TaskGetController Submission ","email: ", email)
	task := DecodeTask(r.Body)
	println(task)

	result := Message(true, "Submit task")

	log.Println("TaskGetController ","email:", email, " date: ", "123")

	//log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result)
}