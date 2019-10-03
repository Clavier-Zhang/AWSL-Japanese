package main

import (
	"github.com/gorilla/mux"
	"net/http"
	"os"
	"server/app"
	."server/controllers"


	"fmt"


)

func main() {


	router := mux.NewRouter()

	router.HandleFunc("/api/user/create", UserCreateController).Methods("POST")
	router.HandleFunc("/api/user/login", UserLoginController).Methods("POST")

	router.HandleFunc("/api/user/test", TestController).Methods("POST")


	router.HandleFunc("/api/contacts/new", CreateContact).Methods("POST")
	router.HandleFunc("/api/me/contacts", GetContactsFor).Methods("GET")

	router.Use(app.JwtAuthentication) //attach JWT auth middleware

	port := os.Getenv("PORT")
	if port == "" {
		port = "8000"
	}

	fmt.Println(port)

	err := http.ListenAndServe(":" + port, router)
	if err != nil {
		fmt.Print(err)
	}


}
