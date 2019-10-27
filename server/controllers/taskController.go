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


	result := Message(true, "Get task by date")


	words := *FindAllLimit()
	result["words"] = words

	log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result)
}


func TaskSubmitController(w http.ResponseWriter, r *http.Request) {

	vars := mux.Vars(r)
	result := Message(true, "Get task by date")


	words := *FindAllLimit()
	result["words"] = words

	log.Println("TaskGetController ","email:", vars["email"], " date: ", vars["date"])

	Respond(w, result)
}