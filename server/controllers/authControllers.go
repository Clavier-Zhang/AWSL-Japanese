package controllers

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"net/http"
	"server/models/user"
	"server/utils"
	"strings"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		utils.Respond(w, utils.Message(false, "Invalid request body"), "Invalid request body", requestUser.Email)
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindUserByEmail(requestUser.Email)

	// Not found in database
	if dbUser == nil {
		utils.Respond(w, utils.Message(false, "Email not exist"), "UserLoginController: Fail", requestUser.Email)
		return
	}

	// Password not match
	if !utils.SameHashPassword(dbUser.Password, requestUser.Password) {
		utils.Respond(w, utils.Message(false, "Password not match"), "UserLoginController: Fail, Password", requestUser.Email)
		return
	}

	//Create JWT token
	dbUser.Token = user.NewToken()
	dbUser.Save()

	dbUser.Password = ""
	response := utils.Message(true, "Login Success")
	response["user"] = dbUser

	utils.Respond(w, response, "UserLoginController", requestUser.Email)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	requestUser := user.DecodeUser(r.Body)

	// Decoding fails
	if requestUser == nil {
		utils.Respond(w, utils.Message(false, "Invalid request body"), "Invalid request body", requestUser.Email)
		return
	}

	// Email to lowercase
	requestUser.Email = strings.ToLower(requestUser.Email)

	dbUser := user.FindUserByEmail(requestUser.Email)

	// Email has been used
	if dbUser != nil {
		utils.Respond(w, utils.Message(false, "Email has been used"), "Email has been used", requestUser.Email)
		return
	}

	// Wrong email format
	if !strings.Contains(requestUser.Email, "@") {
		utils.Respond(w, utils.Message(false, "Wrong email format"), "Wrong email format", requestUser.Email)
		return
	}

	// Wrong password length
	if len(requestUser.Password) < 6 {
		utils.Respond(w, utils.Message(false, "Wrong password length"), "Wrong password length", requestUser.Email)
		return
	}

	// Convert password to hash
	requestUser.Password = utils.NewHashPassword(requestUser.Password)
	requestUser.ID = primitive.NewObjectID()

	// Generate token
	requestUser.Token = user.NewToken()

	requestUser.Save()

	// Response success
	requestUser.Password = ""
	response := utils.Message(true, "create user")
	response["user"] = requestUser
	utils.Respond(w, response, "UserCreateController", requestUser.Email)

}