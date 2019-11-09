package task

import (
	"context"
	"encoding/json"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"io"
	"log"
	"server/models"
	. "server/models/plan"
	. "server/models/session"
)

func (task *Task) GetWordIDs() (results []primitive.ObjectID) {
	for _, record := range task.Records {
		results = append(results, record.WordID)
	}
	return
}

func Min(x, y int) int {
	if x < y {
		return x
	}
	return y
}

func NewTask(session *Session, plan *Plan, date int) *Task {
	task := &Task{}
	task.ID = primitive.NewObjectID()
	task.IsCompleted = false
	task.Email = session.Email
	task.Date = date
	task.Records = map[string]Record{}

	var wordIds []primitive.ObjectID
	remain := session.ScheduledWordCount
	reviews := session.GetReviewWordIds(date)

	// Get words from review
	fromReviewCount := Min(remain, len(reviews))
	for i := 0; i < fromReviewCount; i++ {
		wordIds = append(wordIds, reviews[i])
	}
	remain -= fromReviewCount

	// Get words from plan
	planWordIds := session.GetNewWordIdsFromPlan(plan)
	fromPlanCount := Min(remain, len(planWordIds))
	for i := 0; i < fromPlanCount; i++ {
		wordIds = append(wordIds, planWordIds[i])
	}

	// Create cards
	for _, wordId := range wordIds {
		task.Records[wordId.Hex()] = NewRecord(wordId)
	}

	return task
}

func FindTaskByEmailAndDate(email string, date int) *Task {
	task := &Task{}
	filter := bson.D{{"email", email}, {"date", date}}
	err := models.DB.Collection("task").FindOne(context.TODO(), filter).Decode(&task)
	if err != nil {
		return nil
	}
	return task
}

func (task *Task) Save() {

	var result Task
	filter := bson.D{{"email", task.Email}, {"date", task.Date}}
	err := models.DB.Collection("task").FindOne(context.TODO(), filter).Decode(&result)

	if err == mongo.ErrNoDocuments {
		// Not exist, insert directly
		_, _ = models.DB.Collection("task").InsertOne(context.TODO(), task)
	} else {
		log.Println("delete insert")
		task.ID = result.ID
		_, _ = models.DB.Collection("task").DeleteOne(context.TODO(), filter)
		_, _ = models.DB.Collection("task").InsertOne(context.TODO(), task)
	}

}



func DecodeTask(body io.Reader) *Task {
	task := &Task{}
	err := json.NewDecoder(body).Decode(task)
	if err != nil {
		return nil
	}
	return task
}