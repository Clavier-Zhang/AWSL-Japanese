package word

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"server/models"
)

// Constructor for Example
func NewExample() *Example {
	example := &Example{}
	example.Translation = ""
	example.Japanese = ""
	return example
}


// Constructor for Word
func NewWord() *Word {
	word := &Word{}
	word.Text = ""
	word.Furigara = ""
	word.EN_Meanings = []string{}
	word.EN_Examples = []Example{}
	word.CN_Type = ""
	word.CN_Meanings = []string{}
	word.CN_Examples = []Example{}
	word.Audio = []byte{}
	return word
}


func (word *Word) Exist() bool {
	var result Word
	filter := bson.D{{"text", word.Text}}
	err := models.DB.Collection("word").FindOne(context.TODO(), filter).Decode(&result)
	return err != mongo.ErrNoDocuments
}



func (word *Word) Insert() bool {

	if !word.Exist() {
		_, _ = models.DB.Collection("word").InsertOne(context.TODO(), word)
		return true

	} else {
		// If there is duplication
		return false
	}
}


func (word *Word) Update() bool {

	if word.Exist() {
		// if Text exists in db, update
		filter := bson.D{{"text", word.Text}}

		updatedFields :=  bson.D{}

		if word.Furigara != "" {
			updatedFields = append(updatedFields, bson.E{"furigara", word.Furigara})
		}

		if len(word.EN_Meanings) != 0 {
			updatedFields = append(updatedFields, bson.E{"en_meanings", word.EN_Meanings})
		}

		if len(word.EN_Examples) != 0 {
			updatedFields = append(updatedFields, bson.E{"en_exampless", word.EN_Examples})
		}

		if word.CN_Type != "" {
			updatedFields = append(updatedFields, bson.E{"cn_type", word.CN_Type})
		}

		if len(word.CN_Meanings) != 0 {
			updatedFields = append(updatedFields, bson.E{"cn_meanings", word.CN_Meanings})
		}

		if len(word.CN_Examples) != 0 {
			updatedFields = append(updatedFields, bson.E{"cn_examples", word.CN_Examples})
		}

		// If no fields need to be updated, return directly
		if len(updatedFields) == 0 {
			return false
		}

		update := bson.D{
			{"$set", updatedFields},
		}

		_, _ = models.DB.Collection("word").UpdateOne(context.TODO(), filter, update)

		return true

	}

	return false

}

func FindAllLimit() *[]Word {
	option := options.Find()
	option.SetLimit(10)

	cur, _ := models.DB.Collection("word").Find(context.TODO(), bson.D{{}}, option)
	results := []Word{}
	for cur.Next(context.TODO()) {
		//Create a value into which the single document can be decoded
		word := &Word{}
		_ = cur.Decode(word)
		results = append(results, *word)
	}
	return &results
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