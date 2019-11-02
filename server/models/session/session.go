package session

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"log"
	"server/models"
)

type Session struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Email string `json:"email"`

	CurrentPlan string `json:"current_plan"`

	ScheduledWordCount int `json:"scheduled_word_count"`

	Words map[string]Card `json:"words"`

	FinishedWordIDs []primitive.ObjectID `bson:"finished_word_ids, omitempty"`

	ProgressingWordIDs []primitive.ObjectID `bson:"progressing_word_ids, omitempty"`

}


func (session *Session) GetFinishedWordCount() int {

	return 23

}

func (session *Session) GetprogressingWordCount() int {

	return 23

}


func NewSession(email string) *Session {
	session := &Session{}
	session.Email = email
	session.CurrentPlan = "N5"
	session.ScheduledWordCount = 50
	session.Words = make(map[string]Card)
	session.FinishedWordIDs = []primitive.ObjectID{}
	session.ProgressingWordIDs = []primitive.ObjectID{}
	return session
}

func FindSessionByEmail(email string) *Session {
	session := &Session{}
	filter := bson.D{{"email", email}}
	err := models.DB.Collection("session").FindOne(context.TODO(), filter).Decode(&session)
	// If not found
	if err != nil {
		return nil
	}
	return session
}

func (session *Session) Save() {

	var result Session
	filter := bson.D{{"email", session.Email}}
	err := models.DB.Collection("session").FindOne(context.TODO(), filter).Decode(&result)

	if err == mongo.ErrNoDocuments {
		log.Println("insert")
		// Not exist, insert directly
		_, _ = models.DB.Collection("session").InsertOne(context.TODO(), session)
	} else {
		log.Println("delete insert")
		session.ID = result.ID
		_, _ = models.DB.Collection("session").DeleteOne(context.TODO(), filter)
		_, _ = models.DB.Collection("session").InsertOne(context.TODO(), session)
	}

}