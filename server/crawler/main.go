package main

import (
	//"log"
	//"go.mongodb.org/mongo-driver/bson/primitive"
	. "server/crawler/collectors"
	. "server/models/plan"
	//. "server/models/word"
	//. "server/models/word"
	"strconv"
	. "server/crawler/tools"

	//."server/utils"
)

func main() {
	//s := "https://dict.hjenglish.com/jp/jc/%E6%9C%AA%E3%81%A0???????"
	//fmt.Println(s[:strings.Index(s, "?")])

	//CollectCN(&[]*Word{})
	//UpdateAll()
	//print(ids)
	//FindErrors()
	ClearInvalidPlanWords()
	//FindErrors()

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

