package utils

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/google/uuid"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"golang.org/x/crypto/bcrypt"
	"io"
	"os"

	//"log"
	"net/http"
	"strings"
	"github.com/fatih/color"
	"time"
)

func Message(status bool, message string) (map[string]interface{}) {
	return map[string]interface{} {"status" : status, "message" : message}
}

func Respond(w http.ResponseWriter, data map[string] interface{}, message string, email string)  {
	// log time
	c := color.New(color.FgYellow)
	c.Print(time.Now().Format("2006-01-02 15:04:05"))

	// log status
	if data["status"] == true {
		c = color.New(color.FgGreen)
		c.Print(" SUCCESS ")
	} else {
		c = color.New(color.FgRed)
		c.Print(" FAIL ")
	}

	// log email
	c = color.New(color.FgCyan)
	c.Print(email+" ")

	// log message
	fmt.Println(message)


	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(data)

	// Dont print long data
	for key, _ := range data {
		if key != "status" && key != "message" {
			delete(data, key)
		}
	}
	PrettyPrint(data)
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

func DecodeToMap(body io.Reader) map[string]interface{}{
	data := &map[string]interface{}{}
	_ = json.NewDecoder(body).Decode(data)
	return *data
}

func GetENV(key string) string {
	_ = godotenv.Load()
	return os.Getenv(key)
}