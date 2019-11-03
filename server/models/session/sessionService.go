package session

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"log"
	"server/models"
)

func (session *Session) GetFinishedWordCount() int {
	count := 0
	for _, card := range session.Words {
		if card.GetInterval() > 80 {
			count++
		}
	}
	return count
}

func (session *Session) GetProgressingWordCount() int {
	return len(session.Words)-session.GetFinishedWordCount()
}

func (session *Session) GetWordIDs() []primitive.ObjectID {
	results := []primitive.ObjectID{}
	for _, card := range session.Words {
		results = append(results, card.WordID)
	}
	return results
}


func NewSession(email string) *Session {
	session := &Session{}
	session.Email = email
	session.CurrentPlan = "N5"
	session.ScheduledWordCount = 50
	session.Words = make(map[string]Card)
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