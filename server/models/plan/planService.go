package plan

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"server/models"
)

func NewPlan(name string, creator string) *Plan {
	plan := &Plan{}
	plan.ID = primitive.NewObjectID()
	plan.Creator = creator
	plan.Name = name
	plan.WordIDs = map[string]bool{}
	return plan
}

func FindPlanByName(name string) *Plan {
	plan := &Plan{}
	filter := bson.D{{"name", name}}
	err := models.DB.Collection("plan").FindOne(context.TODO(), filter).Decode(&plan)
	if err != nil {
		return nil
	}
	return plan
}

func (plan *Plan) Save() {
	var result Plan
	filter := bson.D{{"name", plan.Name}}
	err := models.DB.Collection("plan").FindOne(context.TODO(), filter).Decode(&result)

	if err == mongo.ErrNoDocuments {
		_, _ = models.DB.Collection("plan").InsertOne(context.TODO(), plan)
	} else {
		plan.ID = result.ID
		models.DB.Collection("plan").FindOneAndReplace(context.TODO(), filter, plan)
	}

}

func (plan *Plan) Delete() {
	filter := bson.D{{"name", plan.Name}}
	_, _ = models.DB.Collection("plan").DeleteOne(context.TODO(), filter)
}

func (plan *Plan) AddWordId(wordId primitive.ObjectID) {
	if !plan.WordIDs[wordId.Hex()] {
		plan.WordIDs[wordId.Hex()] = true
	}
}

func (plan *Plan) DeleteWordId(wordId primitive.ObjectID) {
	if plan.WordIDs[wordId.Hex()] {
		delete(plan.WordIDs, wordId.Hex())
	}
}


