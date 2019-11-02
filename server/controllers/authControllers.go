package controllers

import (
	"fmt"
	"log"
	"net/http"
	"server/models/user"
	. "server/utils"
	"strings"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		Respond(w, Message(false, "Invalid request body"))
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindByEmail(requestUser.Email)

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
	requestUser.Token = user.NewToken()
	requestUser.Update()

	requestUser.Password = ""
	response := Message(true, "Login Success")
	response["user"] = requestUser

	log.Println("UserLoginController ")
	fmt.Println(response)

	Respond(w, response)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		log.Println("Invalid request body")
		Respond(w, Message(false, "Invalid request body"))
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindByEmail(requestUser.Email)

	// Email has been used
	if dbUser != nil {
		log.Println("Email has been used")
		Respond(w, Message(false, "Email has been used"))
		return
	}

	// Wrong email format
	if !strings.Contains(requestUser.Email, "@") {
		log.Println("Wrong email format")
		Respond(w, Message(false, "Wrong email format"))
		return
	}

	// Wrong password length
	if len(requestUser.Password) < 6 {
		log.Println("Wrong password length")
		Respond(w, Message(false, "Wrong password length"))
		return
	}

	// Convert password to hash
	requestUser.Password = NewHashPassword(requestUser.Password)

	// Generate token
	requestUser.Token = user.NewToken()

	ok := requestUser.Insert()

	if !ok {
		log.Println("Unknown DB errors")
		Respond(w, Message(false, "Unknown DB errors"))
		return
	}

	log.Println("Create user:")
	log.Println(*requestUser)

	// Response success
	requestUser.Password = ""
	response := Message(true, "Account has been created")
	response["user"] = requestUser
	Respond(w, response)

}