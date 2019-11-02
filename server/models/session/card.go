package session

import "go.mongodb.org/mongo-driver/bson/primitive"

type Card struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	WordID primitive.ObjectID `bson:"word_id, omitempty"`

	EF int `json:"EF"`

	SuccessDayCount int `json:"success_day_count"`

	LastReviewedDate int `json:"last_reviewed_date"`

}

