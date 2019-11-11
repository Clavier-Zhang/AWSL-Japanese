package main

import (
	//"go.mongodb.org/mongo-driver/bson/primitive"
	."server/crawler/collectors"
	."server/models/plan"
	"strconv"

	//."server/utils"
)

func main() {

	for i:=1; i <=5; i++ {
		addNPlan(i)
	}


}


func addNPlan(level int) {
	words := CollectEN(level)
	ids := CollectCN(&words)

	plan := NewPlan("N"+strconv.Itoa(level), "ADMIN")
	for _, id := range ids {
		plan.AddWordId(id)
	}
	plan.Save()
}