package user

import (
	"context"
	"encoding/json"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"io"
	"server/models"
)


type User struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Email string `json:"email"`

	Password string `json:"password"`

	Token string `json:"token"`

	name string `json:"name"`

	avatar []byte `json:"avatar"`

}

func (user *User) ExistEmail() bool {
	var result User
	filter := bson.D{{"email", user.Email}}
	err := models.DB.Collection("user").FindOne(context.TODO(), filter).Decode(&result)
	return err != mongo.ErrNoDocuments
}

func FindByToken(token string) *User {
	var result User
	filter := bson.D{{"token", token}}
	err := models.DB.Collection("user").FindOne(context.TODO(), filter).Decode(&result)
	if err == mongo.ErrNoDocuments {
		return nil
	}
	return &result
}

func (user *User) Update() bool {

	if !user.ExistEmail() {
		fmt.Println("Fail to update")
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

	_, _ = models.DB.Collection("user").UpdateOne(context.TODO(), filter, update)

	return true

}


func DecodeUser(body io.Reader) *User {
	user := &User{}
	err := json.NewDecoder(body).Decode(user)
	if err != nil {
		return nil
	}
	return user
}


