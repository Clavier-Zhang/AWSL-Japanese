package main

import (
	//"go.mongodb.org/mongo-driver/bson/primitive"
	."server/crawler/collectors"
	."server/models/plan"

	//."server/utils"
)

func main() {


	words := CollectEN(1)
	ids := CollectCN(&words)

	plan := NewPlan("N1", "ADMIN")
	for _, id := range ids {
		plan.AddWordId(id)
	}
	plan.Save()
}


