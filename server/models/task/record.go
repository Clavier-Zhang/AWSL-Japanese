package task

import "go.mongodb.org/mongo-driver/bson/primitive"

type Record struct {

	WordID primitive.ObjectID `bson:"word_id, omitempty"`

	ReviewCount int `json:"review_count"`

}

func NewRecord(wordID primitive.ObjectID) Record {
	record := Record{}
	record.WordID = wordID
	record.ReviewCount = 0
	return record
}