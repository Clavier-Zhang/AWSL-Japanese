package controllers

import (
	"net/http"
	."server/utils"
)

func TestController(w http.ResponseWriter, r *http.Request) {


	Respond(w, Message(false, "test"))
}