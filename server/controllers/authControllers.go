package controllers

import (
	"fmt"
	"golang.org/x/crypto/bcrypt"
	"net/http"
	. "server/utils"
	."server/models"
	"encoding/json"
)

func UserLoginController(w http.ResponseWriter, r *http.Request) {

	fmt.Println("login")

	user := &User{}
	err := json.NewDecoder(r.Body).Decode(user)
	if err != nil {
		Respond(w, Message(false, "Invalid request"))
		return
	}

	fmt.Println(user)

	if !user.ExistEmail() {
		Respond(w, Message(false, "Email not exist"))
		return
	}

	dbUser := FindByEmail(user.Email)

	err = bcrypt.CompareHashAndPassword([]byte(dbUser.Password), []byte(user.Password))

	if err != nil && err == bcrypt.ErrMismatchedHashAndPassword { //Password does not match!
		Message(false, "Invalid login credentials. Please try again")
		return
	}

	//Create JWT token
	dbUser.Token = NewToken()
	dbUser.Update()


	resp := Message(true, "success login")
	resp["user"] = dbUser


	Respond(w, resp)
}


func UserCreateController(w http.ResponseWriter, r *http.Request) {

	user := &User{}
	err := json.NewDecoder(r.Body).Decode(user)

	if err != nil {
		Respond(w, Message(false, "Invalid request"))
	}

	//if resp, ok := user.isValid(); !ok {
	//	return resp
	//}

	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	user.Password = string(hashedPassword)

	user.Token = NewToken()

	ok := user.Insert()

	if !ok {
		Respond(w, Message(true, "Account has been created"))
		return
	}

	response := Message(true, "Account has been created")
	response["user"] = user

	Respond(w, response)

}