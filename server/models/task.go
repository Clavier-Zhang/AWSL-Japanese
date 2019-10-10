package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"
)

type Task struct {

	Date time.Time `json:"date"`

	Scheduled int `json:"scheduled"`

	Finished int `json:"finished"`

	WordIDs []primitive.ObjectID `bson:"word_ids, omitempty"`
}