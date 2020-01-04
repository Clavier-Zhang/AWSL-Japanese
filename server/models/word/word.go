package word

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Word struct {

	ID primitive.ObjectID `bson:"_id"`

	Text string `json:"text"`

	Label string `json:"label"`

	EnglishMeanings []string `json:"english_meanings"`

	EnglishExamples []Example `json:"english_examples"`

	ChineseType string `json:"chinese_type"`

	ChineseMeanings []string `json:"chinese_meanings"`

	ChineseExamples []Example `json:"chinese_examples"`

	Audio []byte `json:"audio"`

	Romaji string `json:"romaji"`

}

type Example struct {

	Japanese string `json:"japanese"`

	Translation string `json:"translation"`

}


