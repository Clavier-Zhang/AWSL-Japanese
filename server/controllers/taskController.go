package controllers

import (
	//"bytes"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	."server/models"
	."server/utils"
)

func TaskGetController(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	log.Println("test from "+vars["email"])

	result := Message(true, "home")
	words := *FindAllLimit()
	words[6].Audio = []byte{0, 1, 1,1, 2}
	result["words"] = words

	Respond(w, result)
}