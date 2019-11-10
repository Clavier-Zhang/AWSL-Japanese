package collectors


import (
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"log"
	. "server/models/word"
	. "server/utils"
	"strconv"

	//"strconv"
	"unicode/utf8"
	"time"
)


// Link for English Dictionary
const baseENURL = "https://jisho.org/search/"

// Settings for collector
const threadNum = 70
const queueSize = 30000
var collector = colly.NewCollector()
var taskQueue, _ = queue.New(threadNum, &queue.InMemoryQueueStorage{MaxSize: queueSize})


// Results report
var success = 0
var fail = 0
var errorLinks []string
var successWordIds []primitive.ObjectID

func CollectEN(level int) {

	// Start time
	start := time.Now()

	collector.OnHTML("div.concept_light.clearfix", analyzeENPage)

	loadJLPT(level)

	_ = taskQueue.Run(collector)

	// End time
	time := time.Since(start)
	log.Printf("Time: %s, %d success, %d fail", time, success, fail)
	PrettyPrint(errorLinks)
}


func loadJLPT(level int) {
	for page := 1; page < 200; page++ {
		url := baseENURL+"%23jlpt-n"+strconv.Itoa(level)+"%20%23words?page="+strconv.Itoa(page)
		_ = taskQueue.AddURL(url)
	}
}

func GetEnglishText(e *colly.HTMLElement) string {
	return e.ChildText("span.text")
}

func GetEnglishLabel(e *colly.HTMLElement, text string) string {
	// Get Label
	var labels []string
	// Common label
	e.ForEach("span.furigana span", func(_ int, e *colly.HTMLElement) {
		labels = append(labels, e.Text)
	})
	// Justify label
	justifies := map[string]string{}
	e.ForEach("span.furigana ruby", func(_ int, e *colly.HTMLElement) {
		key := ""
		value := ""
		e.ForEach("rb", func(_ int, e *colly.HTMLElement) {
			key = e.Text
		})
		e.ForEach("rt", func(_ int, e *colly.HTMLElement) {
			value = e.Text
		})
		justifies[key] = value
	})

	label := ""

	// If is <justify label>
	if len(justifies) != 0 {
		label = FindSubStringAndReplace(text, justifies)

		// If is common label
	} else {

		// Special case, need manually handle
		if len(labels) != utf8.RuneCountInString(text) {
			return ""
		}
		for i, c := range text {
			if labels[i/3] != "" {
				label += labels[i/3]
			} else {
				label += string(c)
			}
		}
	}
	return label
}


func analyzeENPage(e *colly.HTMLElement) {

	// Get Text
	text := GetEnglishText(e)

	if text == "" {
		return
	}

	label := GetEnglishLabel(e, text)

	if label == "" {
		fail++
		errorLinks = append(errorLinks, text)
		errorLinks = append(errorLinks, e.Request.URL.String())
		return
	}

	word := FindWordByTextAndLabel(text, label)

	if word == nil {
		word = NewWord(text, label)
	}

	// Get EN_Meaning
	e.ForEach("span.meaning-meaning", func(_ int, e *colly.HTMLElement) {
		if e.ChildText("span.break-unit") == "" {
			word.EnglishMeanings = append(word.EnglishMeanings, e.Text)
		}
	})

	// Get Examples
	e.ForEach("div.sentence", func(_ int, e *colly.HTMLElement) {
		example := NewExample()
		// Get Japanese
		e.ForEach("span.unlinked", func(_ int, e *colly.HTMLElement) {
			example.Japanese = example.Japanese + e.Text
		})
		// Get Translation
		example.Translation = e.ChildText("li.english")
		word.EnglishExamples = append(word.EnglishExamples, example)
	})

	word.Save()
	success++

}