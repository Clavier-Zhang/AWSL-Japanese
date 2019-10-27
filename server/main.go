package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
	. "server/controllers"
	. "server/middlewares"
)

func main() {

	router := mux.NewRouter()

	// Authentication
	router.HandleFunc("/api/user/create", UserCreateController).Methods("POST")
	router.HandleFunc("/api/user/login", UserLoginController).Methods("POST")

	// Task
	router.HandleFunc("/api/user/home/{email}", HomeController).Methods("GET")
	router.HandleFunc("/api/task/get/{email}/{date}", TaskGetController).Methods("GET")
	router.HandleFunc("/api/task/submit", TaskSubmitController).Methods("POST")

	// Middleware
	router.Use(JwtAuthentication)

	// err
	err := http.ListenAndServe(":" + "8000", router)

	if err != nil {
		fmt.Print(err)
	}

}
