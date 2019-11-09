package collectors


import (
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"log"
	. "server/models/word"
	. "server/utils"
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
var total = 0
var errorLinks []string


func CollectEN() {

	// Start time
	start := time.Now()

	collector.OnHTML("div.concept_light.clearfix", analyzeENPage)

	loadJLPT()

	_ = taskQueue.Run(collector)

	// End time
	time := time.Since(start)
	log.Printf("%d Tasks takes time %s, %d success, %d fail", total, time, success, fail)
	PrettyPrint(errorLinks)
}


func loadJLPT() {
	_ = taskQueue.AddURL("https://jisho.org/search/%23jlpt-n5%20%23words?page=33")
	//for level := 5; level < 6; level++ {
	//	for page := 1; page < 50; page++ {
	//		url := baseENURL+"%23jlpt-n"+strconv.Itoa(level)+"%20%23words?page="+strconv.Itoa(page)
	//		_ = taskQueue.AddURL(url)
	//	}
	//}
}


func analyzeENPage(e *colly.HTMLElement) {

	total++

	word := NewWord()

	// Get Text
	text := e.ChildText("span.text")

	// Get Label
	labels := []string{}
	// Common label
	e.ForEach("span.furigana span", func(_ int, e *colly.HTMLElement) {
		labels = append(labels, e.Text)
	})
	justifies := map[string]string{}
	// Justify label
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

	if text == "" {
		fail++
		return
	}

	label := ""

	if len(justifies) != 0 {
		label = FindSubStringAndReplace(text, justifies)

	} else {

		if len(labels) != utf8.RuneCountInString(text) {
			fail++
			errorLinks = append(errorLinks, text)
			errorLinks = append(errorLinks, e.Request.URL.String())
			return
		}
		for i, c := range text {
			if labels[i/3] != "" {
				label += labels[i/3]
			} else {
				label += string(c)
			}
		}
	}


	word.Label = label
	word.Text = text


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


	if word.Text != "" && word.Label != "" {
		success++
		PrettyPrint(word)
	}



}