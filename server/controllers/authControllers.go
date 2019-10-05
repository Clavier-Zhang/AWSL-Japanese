package controllers

import (
	"log"
	"net/http"
	. "server/models"
	. "server/utils"
	"strings"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {

	requestUser := DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		Respond(w, Message(false, "Invalid request body"))
		return
	}

	dbUser := FindByEmail(requestUser.Email)

	// Not found in database
	if dbUser == nil {
		Respond(w, Message(false, "Email not exist"))
		return
	}

	// Password not match
	if !SameHashPassword(dbUser.Password, requestUser.Password) {
		Message(false, "Password not match")
		return
	}

	//Create JWT token
	dbUser.Token = NewToken()
	dbUser.Update()

	resp := Message(true, "Success Login")
	resp["user"] = dbUser

	Respond(w, resp)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	requestUser := DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		Respond(w, Message(false, "Invalid request body"))
		return
	}

	dbUser := FindByEmail(requestUser.Email)

	// Email has been used
	if dbUser != nil {
		Respond(w, Message(false, "Email has been used"))
		return
	}

	// Wrong email format
	if !strings.Contains(requestUser.Email, "@") {
		Respond(w, Message(false, "Wrong email format"))
		return
	}

	// Wrong password length
	if len(requestUser.Password) < 6 {
		Respond(w, Message(false, "Wrong password length"))
		return
	}

	// Convert password to hash
	requestUser.Password = NewHashPassword(requestUser.Password)

	// Generate token
	requestUser.Token = NewToken()

	ok := requestUser.Insert()

	if !ok {
		Respond(w, Message(false, "Unknown DB errors"))
		return
	}

	log.Println("Create user:", requestUser)
	response := Message(true, "Account has been created")
	response["user"] = requestUser
	Respond(w, response)

}