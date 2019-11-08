package session

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
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
