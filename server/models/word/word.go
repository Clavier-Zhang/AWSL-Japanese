package word

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Word struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Text string `json:"text"`

	Furigara string `json:"furigara"`

	EN_Meanings []string `json:"en_meanings"`

	EN_Examples []Example `json:"en_examples"`

	CN_Type string `json:"cn_type"`

	CN_Meanings []string `json:"cn_meanings"`

	CN_Examples []Example `json:"cn_examples"`

	Audio []byte `json:"audio"`

}

type Example struct {

	Japanese string `json:"japanese"`

	Translation string `json:"translation"`

}


