package utils

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/google/uuid"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"golang.org/x/crypto/bcrypt"
	"io"
	"log"
	"net/http"
	"strings"
)

func Message(status bool, message string) (map[string]interface{}) {
	return map[string]interface{} {"status" : status, "message" : message}
}

func Respond(w http.ResponseWriter, data map[string] interface{}, message string)  {
	log.Println(message)
	//PrettyPrint(data)
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
		m[item.Hex()] = true
	}

	for _, item := range b {
		if _, ok := m[item.Hex()]; ok {
			c = append(c, item)
		}
	}
	return
}

func ReaderToBytes(stream io.Reader) []byte {
	buf := new(bytes.Buffer)
	buf.ReadFrom(stream)
	return buf.Bytes()
}


func BytesToFile(bytes []byte) {
	// Convert bytes to mp3 file
	//word := &Word{}
	//filter := bson.D{{"text", "crawler"}}
	//_ = db.Collection("word").FindOne(context.TODO(), filter).Decode(&word)
	//file, _ := os.Create("./crawler.mp3")
	//file.Write(word.Audio)
	//fmt.Println(word.Audio)
}

func FindSubStringAndReplace(s string, m map[string]string) string {
	for key, val := range m {
		index := strings.Index(s, key)
		head := ""
		if index-1 >= 0 {
			head = s[0:index-1]
		}
		tail := ""
		if index+len(key) < len(s) {
			tail = s[index+len(key):]
		}
		s = head + val + tail
	}
	return s
}

