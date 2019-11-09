package utils

import (
	"bytes"
	"io"
)

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

