package models

import (
	"context"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"

)


var DB *mongo.Database


func init() {

	// Set client options
	clientOptions := options.Client().ApplyURI("mongodb://47.89.243.163:27017")

	// Connect to MongoDB
	client, _ := mongo.Connect(context.TODO(), clientOptions)

	// Select Database
	DB = client.Database("awsl")
	log.Printf("Connecting to mongodb database [awsl]")

}


func (word *Word) Exist() bool {
	var result Word
	filter := bson.D{{"text", word.Text}}
	err := DB.Collection("word").FindOne(context.TODO(), filter).Decode(&result)
	return err != mongo.ErrNoDocuments
}


func (word *Word) InsertIfNoDuplicate() {
	if !word.Exist() {
		res, err := DB.Collection("word").InsertOne(context.TODO(), word)
		if err != nil {
			log.Fatal(err, res)
		}
	}
}


func (word *Word) Update() bool {
	if word.Exist() {
		// if Text exists in db, update
		filter := bson.D{{"text", word.Text}}

		updatedFields :=  bson.D{}

		if word.Furigara != "" {
			updatedFields = append(updatedFields, bson.E{"furigara", word.Furigara})
		}

		if len(word.EN_Meanings) != 0 {
			updatedFields = append(updatedFields, bson.E{"en_meanings", word.EN_Meanings})
		}

		if len(word.EN_Examples) != 0 {
			updatedFields = append(updatedFields, bson.E{"en_exampless", word.EN_Examples})
		}

		if word.CN_Type != "" {
			updatedFields = append(updatedFields, bson.E{"cn_type", word.CN_Type})
		}

		if len(word.CN_Meanings) != 0 {
			updatedFields = append(updatedFields, bson.E{"cn_meanings", word.CN_Meanings})
		}

		if len(word.CN_Examples) != 0 {
			updatedFields = append(updatedFields, bson.E{"cn_examples", word.CN_Examples})
		}

		if len(updatedFields) == 0 {
			fmt.Println("No update for ", word.Text)
			return false
		}

		update := bson.D{
			{"$set", updatedFields},
		}

		result, err := DB.Collection("word").UpdateOne(context.TODO(), filter, update)
		if err != nil {
			log.Fatal(err, result)
		}
		fmt.Println("Update ", word.Text)

	}
	return true
}