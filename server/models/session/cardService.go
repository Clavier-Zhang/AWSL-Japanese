package session

import "go.mongodb.org/mongo-driver/bson/primitive"

func NewCard(WordID primitive.ObjectID) *Card {
	card := &Card{}
	card.WordID = WordID
	card.EF = 2.5
	card.LastReviewedDate = 0
	card.SuccessDayCount = 1
	return card
}


func (card *Card) GetInterval() int {
	if card.SuccessDayCount == 1 {
		return 1
	}
	if card.SuccessDayCount == 2 {
		return 6
	}
	result := 6
	for i := 2; i <= card.SuccessDayCount; i++ {
		result = result * card.EF
	}
	return result
}