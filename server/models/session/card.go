package session

import "go.mongodb.org/mongo-driver/bson/primitive"

type Card struct {

	WordID primitive.ObjectID `bson:"word_id"`

	EF float64 `json:"EF"`

	Level int `json:"level"`

	LastReviewDate int `json:"last_reviewed_date"`

}

