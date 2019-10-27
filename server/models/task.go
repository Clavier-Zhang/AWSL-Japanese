package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Task struct {

	Date int `json:"date"`

	Scheduled int `json:"scheduled"`

	Finished int `json:"finished"`

	WordIDs []primitive.ObjectID `bson:"word_ids, omitempty"`
}