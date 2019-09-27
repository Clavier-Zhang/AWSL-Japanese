package models

import (
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/jinzhu/gorm"
	"os"
	"context"
	"github.com/joho/godotenv"
	"fmt"
	"log"
	"go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
)

var db *gorm.DB


func init() {

	e := godotenv.Load()
	if e != nil {
		fmt.Print(e)
}

username := os.Getenv("db_user")
password := os.Getenv("db_pass")
dbName := os.Getenv("db_name")
dbHost := os.Getenv("db_host")


dbUri := fmt.Sprintf("host=%s user=%s dbname=%s sslmode=disable password=%s", dbHost, username, dbName, password)
fmt.Println(dbUri)

conn, err := gorm.Open("postgres", dbUri)
if err != nil {
fmt.Print(err)
}

db = conn
db.Debug().AutoMigrate(&Account{}, &Contact{})
}

func GetDB() *gorm.DB {
	return db
}

func GetClient() *mongo.Client {
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

	fmt.Println("Connected to MongoDB!")
	return client
}