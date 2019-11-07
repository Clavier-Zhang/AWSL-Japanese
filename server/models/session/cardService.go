package session

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	. "server/utils"
)

func NewCard(WordID primitive.ObjectID) *Card {
	card := &Card{}
	card.WordID = WordID
	card.EF = 2.5
	card.LastReviewedDate = 0
	card.SuccessDayCount = 1
	return card
}

func (card *Card) GetNextReviewDayCount() int {
	today := GetToday()
	gap := GetDateGap(today, card.LastReviewedDate)
	return card.GetInterval()-gap
}

func (card *Card) GetInterval() int {
	result := 1.0
	if card.SuccessDayCount >= 2 {
		result = 6
	}
	for i := 2; i <= card.SuccessDayCount; i++ {
		result = result * card.EF
	}
	return int(result)
}