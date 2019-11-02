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
	plan.WordIDs = []primitive.ObjectID{}
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
		// Not exist, insert directly
		_, _ = models.DB.Collection("plan").InsertOne(context.TODO(), plan)
	} else {
		// Delete and insert the new plan
		// Use same ObjectID
		plan.ID = result.ID
		_, _ = models.DB.Collection("plan").DeleteOne(context.TODO(), filter)
		_, _ = models.DB.Collection("plan").InsertOne(context.TODO(), plan)
	}

}