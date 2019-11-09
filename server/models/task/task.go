package task

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Task struct {

	ID primitive.ObjectID `bson:"_id"`

	IsCompleted bool `json:"is_completed"`

	Email string `json:"email"`

	Date int `json:"date"`

	TimeSpent int `json:"time_spent"`

	Records map[string]Record `json:"records"`

}

