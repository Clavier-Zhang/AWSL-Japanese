package tools
import (
	//"fmt"
	"strconv"

	//"encoding/json"
	//"go.mongodb.org/mongo-driver/bson/primitive"

	//"net/url"

	//"net/url"


	//"strconv"

	//"go.mongodb.org/mongo-driver/bson/primitive"
	"log"
	. "server/models/word"
	. "server/models/plan"

)

func ClearInvalidWords() {
	words := FindAllWordIds()
	var errors []Word
	for _, word := range *words {
		if len(word.ChineseMeanings) == 0 || len(word.EnglishMeanings) == 0 || len(word.Romaji) == 0 || len(word.Label) == 0  || len(word.Text) == 0 {
			errors = append(errors, word)
		}
	}
	log.Println("total errors:", len(errors))

	var plans []Plan
	for i := 1; i < 6; i++ {
		plans = append(plans, *FindPlanByName("N"+strconv.Itoa(i)))
	}
	log.Println("plans: ", len(plans))

	for _, word := range errors {
		for i := 0; i < len(plans); i++ {
			delete(plans[i].WordIDs, word.ID.Hex())
		}
	}

	for _, word := range errors {
		word.Delete()
	}
}

func ClearInvalidPlanWords() {
	var plans []Plan
	for i := 1; i < 6; i++ {
		plans = append(plans, *FindPlanByName("N"+strconv.Itoa(i)))
	}
	log.Println("plans: ", len(plans))
	count := 0
	for i := 0; i < len(plans); i++ {
		for id, _ := range plans[i].WordIDs {
			log.Println("Processing", "plan", i+1, "word", id)
			word := FindWordByID(id)
			if word == nil {
				delete(plans[i].WordIDs, id)
				count++
			}
		}
		plans[i].Save()

	}

	log.Println("total count:", count)

}