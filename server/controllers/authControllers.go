package controllers

import (
	"log"
	"net/http"
	u "server/utils"
	"server/models"
	"encoding/json"
)

func UserLoginHandler(w http.ResponseWriter, r *http.Request) {
	user := &models.User{}
	err := json.NewDecoder(r.Body).Decode(user) //decode the request body into struct and failed if any error occur
	if err != nil {
		log.Fatal(err)
		u.Respond(w, u.Message(false, "Invalid request"))
		return
	}
	resp := models.Login(user.Email, user.Password)
	u.Respond(w, resp)
}

func UserCreateHandler(w http.ResponseWriter, r *http.Request) {
	user := &models.User{}
	err := json.NewDecoder(r.Body).Decode(user)
	if err != nil {
		u.Respond(w, u.Message(false, "Invalid request"))
	}
	resp := user.Create()
	u.Respond(w, resp)
}