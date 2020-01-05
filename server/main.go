package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
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
	router.HandleFunc("/api/user/home", HomeController).Methods("GET")
	router.HandleFunc("/api/task/get/{date}", TaskGetController).Methods("GET")
	router.HandleFunc("/api/task/submit", TaskSubmitController).Methods("POST")

	// Plan
	router.HandleFunc("/api/plan/list", PlanListGetController).Methods("GET")

	// Session
	router.HandleFunc("/api/session/update", SessionUpdateController).Methods("POST")

	// Middleware
	router.Use(JwtAuthentication)

	// err
	err := http.ListenAndServe(":" + "8000", router)

	log.Println("Start server on port 8000")

	if err != nil {
		fmt.Print(err)
	}

}

