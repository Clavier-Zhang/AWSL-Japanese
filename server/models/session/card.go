package session

import "go.mongodb.org/mongo-driver/bson/primitive"

type Card struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	WordID primitive.ObjectID `bson:"word_id, omitempty"`

	EF int `json:"EF"`

	SuccessDayCount int `json:"success_day_count"`

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