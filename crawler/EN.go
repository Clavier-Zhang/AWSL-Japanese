package main

import (
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"log"
	"strconv"
	"time"
)

func get_en() {

	// Start time for execution time
	start := time.Now()

	targetURL := "https://jisho.org/search/"

	c := colly.NewCollector()
	count := 0

	q, _ := queue.New(100, &queue.InMemoryQueueStorage{MaxSize: 30000})

	c.OnHTML("div.concept_light.clearfix", func(e *colly.HTMLElement) {

		word := &Word{
			Text: e.ChildText("span.text"),
			EN_Meanings: []string{},
			EN_Examples: []EN_Example{},
		}

		// Get English Meaning
		e.ForEach("span.meaning-meaning", func(_ int, e *colly.HTMLElement) {
			if e.ChildText("span.break-unit") == "" {
				word.EN_Meanings = append(word.EN_Meanings, e.Text)
			}
		})

		// Get Example Sentences
		e.ForEach("div.sentence", func(_ int, e *colly.HTMLElement) {
			japanese := ""
			e.ForEach("span.unlinked", func(_ int, e *colly.HTMLElement) {
				japanese = japanese + e.Text
			})
			sentence := EN_Example{
				Japanese: japanese,
				Translation: e.ChildText("li.english"),
			}
			word.EN_Examples = append(word.EN_Examples, sentence)
		})

		word.InsertIfNoDuplicate()

		count++

	})

	for level := 1; level < 6; level++ {
		for page := 1; page < 200; page++ {
			url := targetURL+"%23jlpt-n"+strconv.Itoa(level)+"%20%23words?page="+strconv.Itoa(page)
			//fmt.Println(url)
			_ = q.AddURL(url)
		}
	}

	_ = q.Run(c)

	elapsed := time.Since(start)
	log.Printf("%d Tasks takes time %s", count, elapsed)

}