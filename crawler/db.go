package main

import (
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"context"
)

var db *mongo.Database
func init() {



	// mongo
	// Set client options
	clientOptions := options.Client().ApplyURI("mongodb://47.89.243.163:27017")

	// Connect to MongoDB
	client, err := mongo.Connect(context.TODO(), clientOptions)

	if err != nil {
		log.Fatal(err)
	}

	// Check the connection
	err = client.Ping(context.TODO(), nil)

	if err != nil {
		log.Fatal(err)
	}

	db = client.Database("awsl")

	fmt.Println("Initialize mongodb successfully")
}


func (word *Word) Exist() bool {
	var result Word
	filter := bson.D{{"text", word.Text}}
	err := db.Collection("word").FindOne(context.TODO(), filter).Decode(&result)
	return err != mongo.ErrNoDocuments
}

func (word *Word) Insert() {
	res, err := db.Collection("word").InsertOne(context.TODO(), word)
	if err != nil {
		log.Fatal(err, res)
	}
	fmt.Println("insert ", word.Text)
}