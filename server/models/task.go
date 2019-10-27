package models

import (
	"encoding/json"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"io"
)

type Task struct {

	Date int `json:"date"`

	Scheduled int `json:"scheduled"`

	Finished int `json:"finished"`

	WordIDs []primitive.ObjectID `bson:"word_ids, omitempty"`
}



func DecodeTask(body io.Reader) *Task {
	task := &Task{}
	err := json.NewDecoder(body).Decode(task)
	if err != nil {
		return nil
	}
	return task
}