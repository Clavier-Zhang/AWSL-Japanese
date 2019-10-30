package controllers

import (
	"log"
	"net/http"
	. "server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {

	email := r.Context().Value("email").(string)


	result := Message(true, "home")

	result["finishedNum"] = 2234
	result["progressingNum"] = 386
	result["currentBook"] = "N1"
	result["todayNewNum"] = 78
	result["todayScheduleNum"] = 300

	log.Println("HomeController ", email)
	PrettyPrint(result)
	println(r.Context().Value("email").(string))
	Respond(w, result)
}