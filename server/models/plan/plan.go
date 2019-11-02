package plan

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Plan struct {

	ID primitive.ObjectID `bson:"_id, omitempty"`

	Name string `json:"name"`

	Creator string `json:"creator"`

	WordIDs []primitive.ObjectID `bson:"word_ids, omitempty"`

}


