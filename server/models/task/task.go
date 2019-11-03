package task

import (
	"encoding/json"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"io"
)

type Task struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	IsCompleted bool `json:"is_completed"`

	Email string `json:"email"`

	Date int `json:"date"`

	TimeSpent int `json:"time_spent"`

	Records map[string]Record `json:"records"`

}

func NewTask(email string, date int, wordIDs []primitive.ObjectID) *Task {
	task := &Task{}
	task.IsCompleted = false
	task.Email = email
	task.Date = date
	for _, wordID := range wordIDs {
		task.Records[wordID.String()] = *NewRecord(wordID)
	}
	return task
}



func DecodeTask(body io.Reader) *Task {
	task := &Task{}
	err := json.NewDecoder(body).Decode(task)
	if err != nil {
		return nil
	}
	return task
}