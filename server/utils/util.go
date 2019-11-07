package utils

import (
	"encoding/json"
	"fmt"
	"github.com/google/uuid"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"golang.org/x/crypto/bcrypt"
	"net/http"
	"strconv"
	"time"
)

func Message(status bool, message string) (map[string]interface{}) {
	return map[string]interface{} {"status" : status, "message" : message}
}

func Respond(w http.ResponseWriter, data map[string] interface{})  {
	PrettyPrint(data)
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(data)
}

// Generate random UUID
func NewUUID() string {
	return uuid.New().String()
}

func SameHashPassword(s1 string, s2 string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(s1), []byte(s2))
	if err != nil && err == bcrypt.ErrMismatchedHashAndPassword {
		return false
	}
	return true
}


func NewHashPassword(s string) string {
	hashed, _ := bcrypt.GenerateFromPassword([]byte(s), bcrypt.DefaultCost)
	return string(hashed)
}

func PrettyPrint(v interface{}) {
	b, err := json.MarshalIndent(v, "", "  ")
	if err == nil {
		fmt.Println(string(b))
	}
	return
}

func Union(a, b []primitive.ObjectID) (c []primitive.ObjectID) {
	m := make(map[string]bool)

	for _, item := range a {
		m[item.String()] = true
	}

	for _, item := range b {
		if _, ok := m[item.String()]; ok {
			c = append(c, item)
		}
	}
	return
}

func GetToday() int {
	today := time.Now()
	str := today.Format("20060102")
	num, _ := strconv.Atoi(str)
	return num
}

func GetDateGap(d1 int, d2 int) int {
	date1, _ := time.Parse("20060102", strconv.Itoa(d1))
	date2, _ := time.Parse("20060102", strconv.Itoa(d2))
	diff := int(date1.Sub(date2).Hours())
	return diff/24
}