package main

import (
	//"bufio"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	//"io"
	//"io/ioutil"
	//"net/http"

	//"bufio"
	//"go.mongodb.org/mongo-driver/bson"
	//"io/ioutil"

	//"go.mongodb.org/mongo-driver/bson"
	"context"
	//"io"
	//"net/http"

	//"go.mongodb.org/mongo-driver/bson"
	//"io"
	//"net/http"
	"os"
)

func main() {

	//url := "http://d1.g.hjfile.cn/voice/jpsound/J51379.mp3"
	////get_en()
	////get_cn()
	//// Create the file
	//file, _ := os.Create("./test.mp3")
	//
	//defer file.Close()
	//
	//// Get the data
	//resp, _ := http.Get(url)
	//
	//
	//defer resp.Body.Close()
	//
	//// Write the body to file
	//_, _ = io.Copy(file, resp.Body)
	//
	//
	//bytess, _ := ioutil.ReadFile("./test.mp3")
	//
	//
	//
	//
	//
	//fileinfo, _ := file.Stat()
	//
	//filesize := fileinfo.Size()
	//
	//bytes := make([]byte, filesize)
	//
	//_, _ = resp.Body.Read(bytes)
	//
	//word := &Word{Text: "test", Audio: bytess}
	//fmt.Println(word.Audio)
	//fmt.Println(filesize)
	//
	//word.InsertIfNoDuplicate()








	word := &Word{}
	filter := bson.D{{"text", "test"}}
	_ = db.Collection("word").FindOne(context.TODO(), filter).Decode(&word)
	file, _ := os.Create("./test.mp3")
	file.Write(word.Audio)
	fmt.Println(word.Audio)








	//byteArray := []byte("to be written to a file\n")
	//_ = ioutil.WriteFile("file.mp3", word.Audio, os.FileMode(0777))



}


