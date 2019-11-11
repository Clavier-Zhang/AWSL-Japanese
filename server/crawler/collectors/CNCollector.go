package collectors


import (
	//"fmt"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"go.mongodb.org/mongo-driver/bson/primitive"

	//"go.mongodb.org/mongo-driver/bson/primitive"
	"log"
	"net/http"
	"strings"
	"time"
	."server/models/word"
	."server/utils"
)


// Link for Chinese Dictionary
const baseCNURL = "https://dict.hjenglish.com/jp/jc/"

var cookies = []*http.Cookie{
	{Name: "HJ_UID", Value: "2cd98d30-faa7-94ac-80ba-ec93268146c7"},
	{Name: "HJ_SID", Value: "699b9cb7-f88f-afd4-c18a-69a70b1c7d72"},
}

var CN_Queue, _ = queue.New(70, &queue.InMemoryQueueStorage{MaxSize: 30000})

// Results
var CN_Success = 0
var CN_Fail = 0
var CN_Errors []string

var m map[string]*Word
var textsMap map[string]bool

func CollectCN(words *[]*Word) []primitive.ObjectID {

	// Start time for execution time
	start := time.Now()
	m = map[string]*Word{}
	textsMap = map[string]bool{}

	// Set Collector
	c := colly.NewCollector()

	_ = c.SetCookies(baseCNURL, cookies)

	c.OnHTML("body", analyzeCNPage)


	for _, word := range *words {
		m[word.Text+word.Label] = word
		textsMap[word.Text] = true
	}

	loadCNQueue(m)

	_ = CN_Queue.Run(c)

	time := time.Since(start)

	success := 0
	fail := 0
	successIds := []primitive.ObjectID{}
	for _, word := range m {
		if len(word.ChineseMeanings) == 0 {
			word.Delete()
			CN_Errors = append(CN_Errors, word.Text, word.Label)
			fail++
		} else {
			success++
			successIds = append(successIds, word.ID)
		}
	}

	log.Printf("Tasks takes time %s, %d success, %d fail", time, success, fail)
	//PrettyPrint(CN_Errors)
	//fmt.Println(CN_Errors)
	return successIds

}


func loadCNQueue(m map[string]*Word) {
	//_ = CN_Queue.AddURL("https://dict.hjenglish.com/jp/jc/%E6%B0%B4%E6%B0%97")

	for text, _ := range textsMap {
		_ = CN_Queue.AddURL(baseCNURL+text)
	}
}



func analyzeCNPage(e *colly.HTMLElement) {

	log.Printf(e.Request.URL.String())

	e.ForEach("div.word-details-pane", func(_ int, e *colly.HTMLElement) {

		text := GetChineseText(e)

		label := GetChineseLabel(e)

		word := m[text+label]

		if word == nil {
			return
		}

		word.ChineseType = GetChineseType(e)

		word.ChineseMeanings = GetChineseMeanings(e)

		word.ChineseExamples = GetChineseExamples(e)

		word.Audio = GetChineseAudio(e)

		word.Save()


	})

}



func GetChineseText(e *colly.HTMLElement) string {
	return e.ChildText("div.word-text h2")
}

func GetChineseLabel(e *colly.HTMLElement) string {
	temp := e.ChildText("div.pronounces")
	start := strings.Index(temp, "[")
	end := strings.Index(temp, "]")
	if start == -1 || end == -1 {
		return temp
	}
	return temp[start+1:end]
}

func GetChineseType(e *colly.HTMLElement) string {
	result := e.ChildText("div.simple h2")
	start := strings.Index(result, "【")
	end := strings.Index(result, "】")
	if start == -1 || end == -1 {
		return result
	}
	return result[start+3:end]
}

func GetChineseMeanings(e *colly.HTMLElement) []string {
	results := []string{}
	e.ForEach("div.simple ul li", func(_ int, e *colly.HTMLElement) {
		results = append(results, e.Text[2:len(e.Text)])
	})
	return results
}

func GetChineseExamples(e *colly.HTMLElement) []Example {
	results := []Example{}
	e.ForEach("div.word-details-item-content li", func(_ int, e *colly.HTMLElement) {
		example := NewExample()
		example.Japanese = e.ChildText("p.def-sentence-from")
		example.Translation = e.ChildText("p.def-sentence-to")
		results = append(results, example)
	})
	return results
}

func GetChineseAudio(e *colly.HTMLElement) []byte {
	audioLink := e.ChildAttr("span.word-audio", "data-src")
	resp, _ := http.Get(audioLink)
	defer resp.Body.Close()
	return ReaderToBytes(resp.Body)
}
