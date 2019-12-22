package user

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/models"
)

func NewUser(email string, password string) *User {
	user := &User{}
	user.ID = primitive.NewObjectID()
	user.Email = email
	user.Password = password
	return user
}

func (user *User) Save() {

	var result User
	filter := bson.D{{"email", user.Email}}
	err := models.DB.Collection("user").FindOne(context.TODO(), filter).Decode(&result)

	if err == mongo.ErrNoDocuments {
		_, _ = models.DB.Collection("user").InsertOne(context.TODO(), user)
	} else {
		user.ID = result.ID
		models.DB.Collection("user").FindOneAndReplace(context.TODO(), filter, user)
	}

}

func (user *User) Delete() {
	filter := bson.D{{"email", user.Email}}
	_, _ = models.DB.Collection("user").DeleteOne(context.TODO(), filter)
}

func FindUserByEmail(email string) *User {
	user := &User{}
	filter := bson.D{{"email", email}}
	err := models.DB.Collection("user").FindOne(context.TODO(), filter).Decode(&user)
	if err != nil {
		return nil
	}
	return user
}