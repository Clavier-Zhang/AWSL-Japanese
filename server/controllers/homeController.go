package controllers

import (
	//"bytes"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	. "server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	log.Println("test from "+vars["email"])

	result := Message(true, "home")

	result["finishedNum"] = 2234
	result["progressingNum"] = 386
	result["currentBook"] = "N1"
	result["todayNewNum"] = 78
	result["todayScheduleNum"] = 300

	log.Println(result)
	Respond(w, result)
}