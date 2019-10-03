package models


import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)


type User struct {

	Email string `json:"email"`

	Password string `json:"password"`

	Token string `json:"token"`

}


func (user *User) Exist() bool {
	var result User
	filter := bson.D{{"email", user.Email}}
	err := DB.Collection("user").FindOne(context.TODO(), filter).Decode(&result)
	return err != mongo.ErrNoDocuments
}


func (user *User) Insert() bool {
	if user.Exist() {
		return false
	}
	_, _ = DB.Collection("user").InsertOne(context.TODO(), user)
	return true
}

func (user *User) Update() bool {

	if !user.Exist() {
		return false
	}

	filter := bson.D{{"email", user.Email}}

	updatedFields :=  bson.D{}

	if user.Email != "" {
		updatedFields = append(updatedFields, bson.E{Key: "email", Value: user.Email})
	}

	if user.Password != "" {
		updatedFields = append(updatedFields, bson.E{Key: "password", Value: user.Password})
	}

	if user.Token != "" {
		updatedFields = append(updatedFields, bson.E{Key: "token", Value: user.Token})
	}

	update := bson.D{
		{"$set", updatedFields},
	}

	_, _ = DB.Collection("word").UpdateOne(context.TODO(), filter, update)

	return true

}