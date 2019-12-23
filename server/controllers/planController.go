package controllers

import (
	"net/http"
	."server/models/session"
	."server/models/plan"
	."server/utils"
)

func PlanListGetController(w http.ResponseWriter, r *http.Request) {
	// Get data
	email := r.Context().Value("email").(string)
	session := FindSessionByEmail(email)
	planOptions := FindAllPlans()
	numOptions := []int{10, 20, 50, 100, 150, 200}
	currentNumOption := 0
	currentPlanOption := 0
	for i, plan := range *planOptions {
		if session.CurrentPlan == plan.Name {
			currentPlanOption = i
		}
	}
	for i, num := range numOptions {
		if session.ScheduledWordCount == num {
			currentNumOption = i
		}
	}

	result := Message(true, "Get plan list")
	result["planOptions"] = planOptions
	result["numOptions"] = numOptions
	result["currentNumOption"] = currentNumOption
	result["currentPlanOption"] = currentPlanOption

	Respond(w, result, "PlanListGetController", email)
}
