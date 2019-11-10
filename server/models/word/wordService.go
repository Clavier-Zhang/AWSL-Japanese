package word

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/models"
)

func NewExample() Example {
	example := Example{}
	example.Japanese = ""
	example.Translation = ""
	return example
}


// Constructor for Word
func NewWord(text string, label string) *Word {
	word := &Word{}
	word.ID = primitive.NewObjectID()
	word.Text = text
	word.Label = label
	word.EnglishMeanings = []string{}
	word.EnglishExamples = []Example{}
	word.ChineseType = ""
	word.ChineseMeanings = []string{}
	word.ChineseExamples = []Example{}
	word.Audio = []byte{}
	return word
}

func FindWordByTextAndLabel(text string, label string) *Word {
	result := &Word{}
	filter := bson.D{{"text", text}, {"label", label}}
	err := models.DB.Collection("word").FindOne(context.TODO(), filter).Decode(&result)
	if err != nil {
		return nil
	}
	return result
}


func (word *Word) Save() {

	var result Word
	filter := bson.D{{"text", word.Text}, {"label", word.Label}}
	err := models.DB.Collection("word").FindOne(context.TODO(), filter).Decode(&result)

	if err == mongo.ErrNoDocuments {
		_, _ = models.DB.Collection("word").InsertOne(context.TODO(), word)
	} else {
		word.ID = result.ID
		_ = models.DB.Collection("word").FindOneAndReplace(context.TODO(), filter, word)
	}

}

func (word *Word) Delete() {

	filter := bson.D{{"text", word.Text}, {"label", word.Label}}
	_, _ = models.DB.Collection("word").DeleteOne(context.TODO(), filter)

}

func WordIdsToWords(wordIDs []primitive.ObjectID) *[]Word {
	words := []Word{}
	filter := bson.M{"_id": bson.M{"$in": wordIDs}}
	cur, err := models.DB.Collection("word").Find(context.TODO(), filter)
	if err != nil {
		return nil
	}
	defer cur.Close(context.Background())
	for cur.Next(context.Background()) {
		word := &Word{}
		_ = cur.Decode(&word)
		words = append(words, *word)
	}
	return &words
}