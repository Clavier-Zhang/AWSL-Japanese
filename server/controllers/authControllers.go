package controllers

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"net/http"
	"server/models/user"
	. "server/utils"
	"strings"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		Respond(w, Message(false, "Invalid request body"), "Invalid request body", requestUser.Email)
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindUserByEmail(requestUser.Email)

	// Not found in database
	if dbUser == nil {
		Respond(w, Message(false, "Email not exist"), "UserLoginController: Fail", requestUser.Email)
		return
	}

	// Password not match
	if !SameHashPassword(dbUser.Password, requestUser.Password) {
		Respond(w, Message(false, "Password not match"), "UserLoginController: Fail, Password", requestUser.Email)
		return
	}

	//Create JWT token
	dbUser.Token = user.NewToken()
	dbUser.Save()

	dbUser.Password = ""
	response := Message(true, "Login Success")
	response["user"] = dbUser

	Respond(w, response, "UserLoginController", requestUser.Email)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		Respond(w, Message(false, "Invalid request body"), "Invalid request body", requestUser.Email)
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindUserByEmail(requestUser.Email)

	// Email has been used
	if dbUser != nil {
		Respond(w, Message(false, "Email has been used"), "Email has been used", requestUser.Email)
		return
	}

	// Wrong email format
	if !strings.Contains(requestUser.Email, "@") {
		Respond(w, Message(false, "Wrong email format"), "Wrong email format", requestUser.Email)
		return
	}

	// Wrong password length
	if len(requestUser.Password) < 6 {
		Respond(w, Message(false, "Wrong password length"), "Wrong password length", requestUser.Email)
		return
	}

	// Convert password to hash
	requestUser.Password = NewHashPassword(requestUser.Password)
	requestUser.ID = primitive.NewObjectID()

	// Generate token
	requestUser.Token = user.NewToken()

	requestUser.Save()

	// Response success
	requestUser.Password = ""
	response := Message(true, "create user")
	response["user"] = requestUser
	Respond(w, response, "UserCreateController", requestUser.Email)

}