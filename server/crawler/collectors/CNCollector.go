package collectors
//
//
//import (
//	"fmt"
//	"github.com/gocolly/colly"
//	"github.com/gocolly/colly/queue"
//	"log"
//	"net/http"
//	"time"
//	."server/models/word"
//	."server/utils"
//)
//
//
//// Link for Chinese Dictionary
//const baseCNURL = "https://dict.hjenglish.com/jp/jc/"
//
//var cookies = []*http.Cookie{
//	{Name: "HJ_UID", Value: "2cd98d30-faa7-94ac-80ba-ec93268146c7"},
//	{Name: "HJ_SID", Value: "9538748b-1acc-91e6-ee48-5a936ee32090"},
//}
//
//var CN_Queue, _ = queue.New(70, &queue.InMemoryQueueStorage{MaxSize: 30000})
//
//// Results
//var CN_Success = 0
//var CN_Fail = 0
//var CN_Errors []string
//
//
//func CollectCN() {
//
//	// Start time for execution time
//	start := time.Now()
//	count := 0
//
//	// Set Collector
//	c := colly.NewCollector()
//
//	_ = c.SetCookies(baseCNURL, cookies)
//
//	c.OnHTML("body", analyzeCNPage)
//
//	loadCNQueue()
//
//	_ = CN_Queue.Run(c)
//
//	time := time.Since(start)
//
//	log.Printf("%d Tasks takes time %s, %d success, %d fail", count, time, CN_Success, CN_Fail)
//	fmt.Println(CN_Errors)
//
//}
//
//
//func loadCNQueue() {
//	texts := *FindAllTexts()
//
//	for i := 0; i < len(texts); i++ {
//		url := baseCNURL+texts[i]
//		_ = CN_Queue.AddURL(url)
//	}
//}
//
//
//
//func analyzeCNPage(e *colly.HTMLElement) {
//
//	if e.ChildText("div.word-text h2") == "" {
//		return
//	}
//
//	word := NewWord()
//
//	// Get Text
//	word.Text = e.ChildText("div.word-text h2")
//
//	// Get CN_Type
//	word.CN_Type = e.ChildText("div.simple h2")
//
//	// Get CN_Meanings
//	e.ForEach("div.simple ul li", func(_ int, e *colly.HTMLElement) {
//		word.CN_Meanings = append(word.CN_Meanings, e.Text[2:len(e.Text)])
//	})
//
//	// Get CN_Examples
//	e.ForEach("div.word-details-item-content li", func(_ int, e *colly.HTMLElement) {
//		example := NewExample()
//		example.Japanese = e.ChildText("p.def-sentence-from")
//		example.Translation = e.ChildText("p.def-sentence-to")
//		word.CN_Examples = append(word.CN_Examples, *example)
//	})
//
//
//	// Get Furigara
//	e.ForEach("div.pronounces span", func(_ int, e *colly.HTMLElement) {
//		if word.Furigara == "" && e.Text != ""{
//			word.Furigara = e.Text[1 : len(e.Text)-1]
//			return
//		}
//	})
//
//	// Get Audio
//	audioLink := e.ChildAttr("span.word-audio", "data-src")
//	resp, _ := http.Get(audioLink)
//	defer resp.Body.Close()
//	word.Audio = ReaderToBytes(resp.Body)
//
//
//
//	ok := word.Update()
//
//	if ok {
//		CN_Success++
//	} else {
//		CN_Fail++
//		CN_Errors = append(CN_Errors, e.Request.URL.String())
//	}
//
//}
//
//
