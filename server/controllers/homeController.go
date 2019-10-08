package controllers

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
	."server/utils"
)

func HomeController(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	log.Println("test from "+vars["email"])

	Respond(w, Message(true, "test"))
}