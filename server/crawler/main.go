package main

import (
	//"go.mongodb.org/mongo-driver/bson/primitive"
	. "server/crawler/collectors"
	. "server/models/plan"
	//. "server/models/word"
	"strconv"

	//."server/utils"
)

func main() {
	//s := "https://dict.hjenglish.com/jp/jc/%E6%9C%AA%E3%81%A0???????"
	//fmt.Println(s[:strings.Index(s, "?")])
	for i:=1; i <=2; i++ {
		addNPlan(i)
	}
	//CollectCN(&[]*Word{})


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

func updateAll() {

}