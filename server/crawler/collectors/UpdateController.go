package collectors


import (
	//"encoding/json"
	"github.com/gocolly/colly"
	//"net/url"

	//"net/url"
	"server/utils"
	"strings"

	//"strconv"

	//"go.mongodb.org/mongo-driver/bson/primitive"
	"log"
	. "server/models/word"

	"time"
)

var words_map map[string]string

func FindErrors() []string {
	words := FindAllWordIds()
	var errors []string
	for _, word := range *words {
		if len(word.ChineseMeanings) == 0 {
			errors = append(errors, word.Text)
		}
	}
	log.Println(errors)
	return errors
}

func UpdateAll()  {

	success = 0
	fail = 0
	errorLinks = []string{}
	successWords = []*Word{}
	start = time.Now()
	words_map = map[string]string{}

	collector.OnHTML("body", analyzeUpdatePage)


	collector.OnRequest(func(r *colly.Request) {
		log.Println("start", r.URL.String())
		r.Headers.Set("User-Agent", "PostmanRuntime/7.21.0")
	})

	loadUpdate()


	_ = taskQueue.Run(collector)

	// End time
	time := time.Since(start)

	// Output
	log.Printf("Time: %s, %d success, %d fail", time, success, fail)
	utils.PrettyPrint(errorLinks)

}

func loadUpdate() {
	//taskQueue.AddURL("https://www.japandict.com/%E6%93%A6%E3%82%8B")
	log.Println("Start loading tasks")
	//words := FindAllWordIds()
	//for _, word := range *words {
	//	url := "https://www.japandict.com/"+word.Text
	//	_ = taskQueue.AddURL(url)
	//}



	log.Println("Finish loading tasks")
}


type  Pair  struct {
	romaji string
	label string
}

func analyzeUpdatePage(e *colly.HTMLElement) {

	log.Printf("Time: %s, %d success, %d fail", time.Since(start), success, fail)

	//url := e.Request.URL.String()
	//log.Println("Start analyzing "+url)

	var updateText string
	e.ForEach("h1.display-1", func(_ int, e *colly.HTMLElement) {
		updateText = e.Text
	})


	var pairs []Pair

	e.ForEach("li.list-group-item", func(_ int, e *colly.HTMLElement) {
		updateRomaji := ""
		updateLabel := ""
		e.ForEach("span", func(_ int, e *colly.HTMLElement) {
			updateRomaji = e.Text
		})

		updateLabel = strings.TrimSpace(e.Text)
		updateLabel = strings.Split(updateLabel, " ")[0]

		if len(updateLabel) > 0  && len(updateRomaji) > 0 {
			p := Pair{}
			p.romaji = updateRomaji
			p.label = updateLabel
			pairs = append(pairs, p)
		}
	})

	oneSuccess := false

	for _, p := range pairs {
		word := FindWordByTextAndLabel(updateText, p.label)
		if word == nil {
			continue
		}
		word.Romaji = p.romaji
		oneSuccess = true
		word.Save()

	}

	if oneSuccess {
		success++
	} else {
		fail++
		errorLinks = append(errorLinks, e.Request.URL.String())
	}



}
