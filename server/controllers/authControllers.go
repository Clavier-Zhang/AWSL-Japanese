package controllers

import (
	"golang.org/x/crypto/bcrypt"
	"net/http"
	u "server/utils"
	."server/models"
	"encoding/json"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {
	user := &User{}
	err := json.NewDecoder(r.Body).Decode(user)
	if err != nil {
		u.Respond(w, u.Message(false, "Invalid request"))
		return
	}

	if !user.ExistEmail() {
		u.Respond(w, u.Message(false, "Email not exist"))
		return
	}

	dbUser := FindByEmail(user.Email)

	err = bcrypt.CompareHashAndPassword([]byte(dbUser.Password), []byte(user.Password))

	if err != nil && err == bcrypt.ErrMismatchedHashAndPassword { //Password does not match!
		u.Message(false, "Invalid login credentials. Please try again")
		return
	}

	//Create JWT token
	dbUser.Token = NewToken()
	dbUser.Update()


	resp := u.Message(true, "success login")
	resp["user"] = dbUser


	u.Respond(w, resp)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	user := &User{}
	err := json.NewDecoder(r.Body).Decode(user)

	if err != nil {
		u.Respond(w, u.Message(false, "Invalid request"))
	}

	//if resp, ok := user.isValid(); !ok {
	//	return resp
	//}

	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	user.Password = string(hashedPassword)

	user.Token = NewToken()

	ok := user.Insert()

	if !ok {
		u.Respond(w, u.Message(true, "Account has been created"))
		return
	}

	response := u.Message(true, "Account has been created")
	response["user"] = user

	u.Respond(w, response)

}