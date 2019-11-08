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
)

func (task *Task) GetWordIDs() (results []primitive.ObjectID) {
	for _, record := range task.Records {
		results = append(results, record.WordID)
	}
	return
}

func NewTask(email string, date int, wordIDs []primitive.ObjectID) *Task {
	task := &Task{}
	task.IsCompleted = false
	task.Email = email
	task.Date = date
	for _, wordID := range wordIDs {
		task.Records[wordID.Hex()] = *NewRecord(wordID)
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