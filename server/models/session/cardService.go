package session

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"math"
	"strconv"
	"time"
)

func NewCard(WordID primitive.ObjectID) Card {
	card := Card{}
	card.WordID = WordID
	card.EF = 2.5
	card.LastReviewDate = 0
	card.Level = 1
	return card
}

func (card *Card) GetRemainDaysForNextReview(date int) int {
	daysAfterReview := GetDateGap(date, card.LastReviewDate)
	return card.GetInterval() - daysAfterReview
}

func (card *Card) GetInterval() int {
	if card.Level == 1 {
		return 1
	}
	if card.Level == 2 {
		return 6
	}
	result := 6.0
	for i := 3; i <= card.Level; i++ {
		result = result * card.EF
	}
	return int(result)
}

func GetToday() int {
	today := time.Now()
	str := today.Format("20060102")
	num, _ := strconv.Atoi(str)
	return num
}

func GetDateGap(d1 int, d2 int) int {
	date1, _ := time.Parse("20060102", strconv.Itoa(d1))
	date2, _ := time.Parse("20060102", strconv.Itoa(d2))
	diff := int(date1.Sub(date2).Hours())
	return diff/24
}

func (card Card) SetLevel(level int) {
	card.Level = level
}

func (card *Card) ReceiveResponseQuality(reviewCount int, today int) {
	q := 5.0
	needReview := false
	if reviewCount == 0 {
		// Easy
		card.Level = 10

	} else if reviewCount == 1 {
		// Correct
		q = 5
		card.Level++

	} else if reviewCount <= 4 {
		q = 4
		needReview = true

	} else {
		q = 3
		needReview = true
	}

	EF := card.EF
	newEF := EF+(0.1-(5.0-q)*(0.08+(5.0-q)*0.02))
	newEF = math.Max(1.3, newEF)
	newEF = math.Min(2.5, newEF)
	card.EF = newEF

	if needReview {
		card.Level = 1
	}

	card.LastReviewDate = today

}