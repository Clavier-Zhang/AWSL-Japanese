package models

import (
	"context"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
)


var DB *mongo.Database

// Initialize db package
func init() {

	// Set client options
	clientOptions := options.Client().ApplyURI("mongodb://47.89.243.163:27017")

	// Connect to MongoDB
	client, _ := mongo.Connect(context.TODO(), clientOptions)

	// Select Database
	DB = client.Database("awsl")
	log.Printf("Connecting to mongodb database [awsl]")

}




