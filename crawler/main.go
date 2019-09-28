package main

import (

	"fmt"

	"strconv"

	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
)



func get_en() {
	targetURL := "https://jisho.org/search/"

	c := colly.NewCollector()
	count := 0

	q, _ := queue.New(50, &queue.InMemoryQueueStorage{MaxSize: 30000})

	c.OnHTML("div.concept_light.clearfix", func(e *colly.HTMLElement) {

		furigana := ""

		e.ForEach("span.kanji", func(_ int, e *colly.HTMLElement) {
			furigana = furigana + e.Text
		})

		word := &Word{
			Text: e.ChildText("span.text"),
			Furigara: furigana,
		}

		if !word.Exist() {
			word.Insert()
		} else {
			fmt.Println("Exist ", word.Text)
		}

		count++

	})

	c.OnRequest(func(r *colly.Request) {
		fmt.Println("visiting", r.URL)
	})

	for level := 1; level < 6; level++ {
		for page := 1; page < 200; page++ {
			url := targetURL+"%23jlpt-n"+strconv.Itoa(level)+"%20%23words?page="+strconv.Itoa(page)
			fmt.Println(url)
			_ = q.AddURL(url)
		}
	}

	_ = q.Run(c)

	fmt.Println(count)
}

func main() {

	get_en()

}



func get_cn() {
	dictUrl := "https://dict.hjenglish.com/jp/"

	c := colly.NewCollector()

	q, _ := queue.New(
		10,
		&queue.InMemoryQueueStorage{MaxSize: 10000},
	)

	c.OnRequest(func(r *colly.Request) {
		fmt.Println("visiting", r.URL)
	})

	for i := 0; i < 5; i++ {
		// Add URLs to the queue
		_ = q.AddURL(fmt.Sprintf("%s?n=%d", dictUrl, i))
	}
	// Consume URLs
	_ = q.Run(c)
}