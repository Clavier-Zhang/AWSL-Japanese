package models

import (
	"context"
	"fmt"
	"github.com/dgrijalva/jwt-go"
	"github.com/jinzhu/gorm"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"golang.org/x/crypto/bcrypt"
	"os"
	u "server/utils"
	"strings"
)


//a struct to rep user account
type Account struct {
	gorm.Model
	Email string `json:"email"`
	Password string `json:"password"`
	Token string `json:"token";sql:"-"`
}



//Validate incoming user details...
func (account *Account) Validate() (map[string] interface{}, bool) {

	if !strings.Contains(account.Email, "@") {
		return u.Message(false, "Email address is required"), false
	}

	if len(account.Password) < 6 {
		return u.Message(false, "Password is required"), false
	}

	//Email must be unique
	temp := &Account{}

	//check for errors and duplicate emails
	err := GetDB().Table("accounts").Where("email = ?", account.Email).First(temp).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return u.Message(false, "Connection error. Please retry"), false
	}
	if temp.Email != "" {
		return u.Message(false, "Email address already in use by another user."), false
	}

	return u.Message(false, "Requirement passed"), true
}

func (account *Account) CreateYt() (map[string] interface{}) {

	if resp, ok := account.Validate(); !ok {
		return resp
	}

	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(account.Password), bcrypt.DefaultCost)
	account.Password = string(hashedPassword)

	GetDB().Create(account)


	//Create new JWT token for the newly registered account
	tk := &Token{Text: account.Email}
	token := jwt.NewWithClaims(jwt.GetSigningMethod("HS256"), tk)
	tokenString, _ := token.SignedString([]byte(os.Getenv("token_password")))

	account.Token = tokenString

	account.Password = "" //delete password

	response := u.Message(true, "Account has been created")
	response["account"] = account



	// ***************************
	filter := bson.D{{"email", "zyc1014551629@gmail.com"}}

	update := bson.M{"$set": bson.M{"token": "42"}}
	updateResult, err := GetClient().Collection("user").UpdateOne(context.TODO(), filter, update)
	fmt.Print(updateResult)
	fmt.Print(err)

	// ***************************


	return response
}




func (user *User) isValid() (map[string] interface{}, bool) {

	if !strings.Contains(user.Email, "@") {
		return u.Message(false, "Email format not correct"), false
	}

	if len(user.Password) < 6 {
		return u.Message(false, "Password must be longer than 6 characters"), false
	}

	var result User
	filter := bson.D{{"email", user.Email}}

	err := GetClient().Collection("user").FindOne(context.TODO(), filter).Decode(&result)
	if (err != mongo.ErrNoDocuments) {
		return u.Message(false, "Email address already in use by another user."), false
	}

	return u.Message(false, "Requirement passed"), true
}


