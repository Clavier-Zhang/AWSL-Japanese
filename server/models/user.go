package models

import (
	"github.com/dgrijalva/jwt-go"
)

type Token struct {
	UserId uint
	jwt.StandardClaims
}

type User struct {
	Email string
	Password string
	Token string
}