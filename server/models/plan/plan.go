package plan

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Plan struct {

	ID primitive.ObjectID `bson:"_id"`

	Name string `json:"name"`

	Creator string `json:"creator"`

	WordIDs map[string]bool `json:"word_ids"`

}


