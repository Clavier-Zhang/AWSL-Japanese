package models

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Session struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Email string `json:"email"`

	FinishedWordCount int `json:"finished_word_count"`

	ProgressingWordCount int `json:"progressing_word_count"`

	CurrentPlan string `json:"current_plan"`

	ScheduledWordCount int `json:"scheduled_word_count"`

}


func NewSession(email string) *Session {
	session := &Session{}
	session.Email = email
	session.CurrentPlan = "N5"
	session.ProgressingWordCount = 0
	session.FinishedWordCount = 0
	session.ScheduledWordCount = 50
	return session
}

func FindSessionByEmail(email string) *Session {
	session := &Session{}
	filter := bson.D{{"email", email}}
	err := DB.Collection("user").FindOne(context.TODO(), filter).Decode(&session)
	// If not found
	if err != nil {
		return nil
	}
	return session
}
