package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
	"server/app"
	. "server/controllers"
)

func main() {


	router := mux.NewRouter()

	router.HandleFunc("/api/user/create", UserCreateController).Methods("POST")
	router.HandleFunc("/api/user/login", UserLoginController).Methods("POST")

	router.HandleFunc("/api/user/test", TestController).Methods("POST")
	router.Use(app.JwtAuthentication) //attach JWT auth middleware



	err := http.ListenAndServe(":" + "8000", router)

	if err != nil {
		fmt.Print(err)
	}


}
