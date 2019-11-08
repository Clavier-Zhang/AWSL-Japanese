package plan

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Plan struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Name string `json:"name"`

	Creator string `json:"creator"`

	WordIDs map[string]bool `bson:"word_ids, omitempty"`

}


