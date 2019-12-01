package session

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/models"
	."server/models/plan"
	"sort"
)

type Pair struct {
	ID primitive.ObjectID
	value int
}

func (session *Session) GetReviewWordIds(today int) []primitive.ObjectID {
	var results []Pair
	for _, card := range session.Cards {
		remainDays := card.GetRemainDaysForNextReview(today)
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
	return wordIDs
}

func (session *Session) GetFinishedWordCount() int {
	count := 0
	for _, card := range session.Cards {
		if card.GetInterval() > 80 {
			count++
		}
	}
	return count
}

func (session *Session) GetProgressingWordCount() int {
	return len(session.Cards)-session.GetFinishedWordCount()
}

func NewSession(email string) *Session {
	session := &Session{}
	session.ID = primitive.NewObjectID()
	session.Email = email
	session.CurrentPlan = "N5"
	session.ScheduledWordCount = 10
	session.Cards = map[string]Card{}
	return session
}

func FindSessionByEmail(email string) *Session {
	session := &Session{}
	filter := bson.D{{"email", email}}
	err := models.DB.Collection("session").FindOne(context.TODO(), filter).Decode(&session)
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
		_, _ = models.DB.Collection("session").InsertOne(context.TODO(), session)
	} else {
		session.ID = result.ID
		models.DB.Collection("session").FindOneAndReplace(context.TODO(), filter, session)
	}

}

func (session *Session) Delete() {
	filter := bson.D{{"email", session.Email}}
	_, _ = models.DB.Collection("session").DeleteOne(context.TODO(), filter)
}

func (session *Session) AddCard(wordId primitive.ObjectID) {
	key := wordId.Hex()
	if session.Cards[key] == (Card{}) {
		session.Cards[key] = NewCard(wordId)
	} else {
		temp := session.Cards[key]
		temp.Level = 1
		session.Cards[key] = temp
	}
}

func (session *Session) SetCardLevel(wordId primitive.ObjectID, level int) {
	key := wordId.Hex()
	temp := session.Cards[key]
	temp.Level = level
	session.Cards[key] = temp
}

func (session *Session) SetCardLastReviewDate(wordId primitive.ObjectID, date int) {
	key := wordId.Hex()
	temp := session.Cards[key]
	temp.LastReviewDate = date
	session.Cards[key] = temp
}

func (session *Session) GetNewWordIdsFromPlan(plan *Plan) []primitive.ObjectID {
	var results []primitive.ObjectID
	for id, _ := range plan.WordIDs {
		if session.Cards[id] == (Card{}) {
			objectId, _ := primitive.ObjectIDFromHex(id)
			results = append(results, objectId)
		}
	}
	return results
}