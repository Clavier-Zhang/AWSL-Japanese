package collectors

import (
	"fmt"
	"github.com/gocolly/colly"
	"github.com/gocolly/colly/queue"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"net/http"
	"time"
	"context"
	."crawler/models"
	."crawler/utils"
)

func CollectCN() {

	// Start time for execution time
	start := time.Now()
	count := 0
	errors := []string{}

	// DC Source
	targetURL := "https://dict.hjenglish.com/jp/jc/"

	// Set Collector
	c := colly.NewCollector()

	cookies := []*http.Cookie{
		{Name: "HJ_UID", Value: "2cd98d30-faa7-94ac-80ba-ec93268146c7"},
		{Name: "HJ_SID", Value: "9538748b-1acc-91e6-ee48-5a936ee32090"},
	}

	_ = c.SetCookies(targetURL, cookies)

	c.OnHTML("body", func(e *colly.HTMLElement) {

		if e.ChildText("div.word-text h2") == "" {
			count++
			return
		}

		word := &Word{
			Text: e.ChildText("div.word-text h2"),
			CN_Type: e.ChildText("div.simple h2"),
			CN_Meanings: []string{},
			CN_Examples: []CN_Example{},
			Furigara: "",
		}

		e.ForEach("div.simple ul li", func(_ int, e *colly.HTMLElement) {
			word.CN_Meanings = append(word.CN_Meanings, e.Text[2:len(e.Text)])
		})

		e.ForEach("div.word-details-item-content li", func(_ int, e *colly.HTMLElement) {
			example := CN_Example{
				Japanese: e.ChildText("p.def-sentence-from"),
				Translation: e.ChildText("p.def-sentence-to"),
			}
			word.CN_Examples = append(word.CN_Examples, example)
		})

		e.ForEach("div.pronounces span", func(_ int, e *colly.HTMLElement) {
			if word.Furigara == "" && e.Text != ""{
				word.Furigara = e.Text[1 : len(e.Text)-1]
				return
			}
		})

		// Collect Audio
		audioLink := e.ChildAttr("span.word-audio", "data-src")
		resp, _ := http.Get(audioLink)
		defer resp.Body.Close()
		word.Audio = ReaderToBytes(resp.Body)


		word.Update()
		fmt.Println(word)

	})

	c.OnRequest(func(r *colly.Request) {
		fmt.Println("visiting", r.URL)
	})

	// Set Queue
	q, _ := queue.New(70, &queue.InMemoryQueueStorage{MaxSize: 30000})

	cur, _ := DB.Collection("word").Find(context.TODO(), bson.D{{}}, options.Find())
	results := []string{}
	for cur.Next(context.TODO()) {
		//Create a value into which the single document can be decoded
		word := &Word{}
		_ = cur.Decode(word)
		results = append(results, word.Text)

	}

	for i := 0; i < len(results); i++ {
		url := targetURL+results[i]
		_ = q.AddURL(url)
		fmt.Println(results[i])
	}


	_ = q.Run(c)

	elapsed := time.Since(start)

	fmt.Println(errors)
	log.Printf("%d Tasks takes time %s", count, elapsed)

}





