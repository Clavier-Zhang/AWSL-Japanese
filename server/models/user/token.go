package user


import (
	"github.com/dgrijalva/jwt-go"
	."server/utils"
)



type Token struct {

	Text string

	jwt.StandardClaims

}


func NewToken() string {
	tk := &Token{Text: NewUUID()}
	token := jwt.NewWithClaims(jwt.GetSigningMethod("HS256"), tk)
	tokenString, _ := token.SignedString([]byte("test"))
	return tokenString
}