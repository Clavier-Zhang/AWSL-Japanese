package main

import (
	"github.com/gocolly/colly"
	"github.com/gorilla/mux"
	"net/http"
	"os"
	"server/app"
	"server/controllers"


	"fmt"


)

func main() {


	router := mux.NewRouter()

	router.HandleFunc("/api/user/create", controllers.UserCreateHandler).Methods("POST")
	router.HandleFunc("/api/user/login", controllers.UserLoginHandler).Methods("POST")


	router.HandleFunc("/api/contacts/new", controllers.CreateContact).Methods("POST")
	router.HandleFunc("/api/me/contacts", controllers.GetContactsFor).Methods("GET") //  user/2/contacts

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
