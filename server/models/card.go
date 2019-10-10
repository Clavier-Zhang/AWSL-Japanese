package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Card struct {

	UserID primitive.ObjectID `bson:"user_id, omitempty"`

	WordID primitive.ObjectID `bson:"word_id, omitempty"`

	DifficultyFactor int `json:"difficulty_factor"`

	SuccessDays int `json:"success_days"`

}
