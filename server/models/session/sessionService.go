package session

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/models"
	"sort"
)

type Pair struct {
	ID primitive.ObjectID
	value int
}


func (session *Session) GetReviewWords() *[]primitive.ObjectID {
	results := []Pair{}
	for _, card := range session.Words {
		remainDays := card.GetNextReviewDayCount()
		if remainDays <= 0 {
			results = append(results, Pair{card.WordID, remainDays})
		}
	}
	sort.Slice(results, func(i, j int) bool {
		return results[i].value < results[j].value
	})
	wordIDs := []primitive.ObjectID{}
	for _, p := range results {
		wordIDs = append(wordIDs, p.ID)
	}
	return &wordIDs
}

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
	session.ID = primitive.NewObjectID()
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
		// Not exist, insert directly
		_, _ = models.DB.Collection("session").InsertOne(context.TODO(), session)
	} else {
		session.ID = result.ID
		models.DB.Collection("session").FindOneAndReplace(context.TODO(), filter, session)
	}

}