package models

import (
	"context"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	. "server/utils"
)

var DB *mongo.Database

func init() {

	log.Println(GetENV("MODE")+" Mode")
	log.Println("DB Server: "+ GetENV("DB_SERVER"))
	log.Println("DB Name: "+GetENV("DB_NAME"))

	// Set client options
	clientOptions := options.Client().ApplyURI(GetENV("DB_SERVER"))

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

	DB = client.Database(GetENV("DB_NAME"))

}
