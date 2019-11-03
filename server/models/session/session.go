package session

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Session struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Email string `json:"email"`

	CurrentPlan string `json:"current_plan"`

	ScheduledWordCount int `json:"scheduled_word_count"`

	Words map[string]Card `json:"words"`

}

