package collectors


import (
	. "crawler/models"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"log"
	"strconv"
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
	log.Println("Error words")
	log.Println(errorLinks)

}


func loadJLPT() {
	for level := 1; level < 6; level++ {
		for page := 1; page < 200; page++ {
			url := baseENURL+"%23jlpt-n"+strconv.Itoa(level)+"%20%23words?page="+strconv.Itoa(page)
			_ = taskQueue.AddURL(url)
		}
	}
}


func analyzeENPage(e *colly.HTMLElement) {

	word := NewWord()

	// Get Text
	word.Text = e.ChildText("span.text")

	// Get EN_Meaning
	e.ForEach("span.meaning-meaning", func(_ int, e *colly.HTMLElement) {
		if e.ChildText("span.break-unit") == "" {
			word.EN_Meanings = append(word.EN_Meanings, e.Text)
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
		word.EN_Examples = append(word.EN_Examples, *example)
	})

	// Update result to database
	ok := word.Insert()

	// Return results
	if !ok {
		fail++
		errorLinks = append(errorLinks, word.Text)
	} else {
		success++
	}

}