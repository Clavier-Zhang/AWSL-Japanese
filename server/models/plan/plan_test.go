package plan

import (
	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
)

func Test_Save_Delete_Find(t *testing.T) {
	name := "test_plan"

	plan := NewPlan(name, "test_user_1")
	plan.Save()
	result := FindPlanByName(name)
	assert.NotNil(t, result)
	assert.Equal(t, result.Creator, "test_user_1")
	assert.NotEqual(t, result.ID, primitive.ObjectID{})
	id := result.ID

	plan.Creator = "test_user_2"
	plan.Save()
	result = FindPlanByName(name)
	assert.NotNil(t, result)
	assert.Equal(t, result.Creator, "test_user_2")
	assert.Equal(t, result.ID, id)

	plan.Delete()
	assert.Nil(t, FindPlanByName(name))

	plan.Delete()
	assert.Nil(t, FindPlanByName(name))
}

func Test_Add_Remove_WordID(t *testing.T) {
	name := "test_plan"
	plan := NewPlan(name, "test_user_1")

	id1 := primitive.NewObjectID()
	id2 := primitive.NewObjectID()
	plan.AddWordId(id1)
	plan.AddWordId(id1)
	assert.Equal(t, len(plan.WordIDs), 1)
	assert.True(t, plan.WordIDs[id1.Hex()])

	plan.DeleteWordId(id1)
	assert.Equal(t, len(plan.WordIDs), 0)
	plan.DeleteWordId(id1)
	assert.Equal(t, len(plan.WordIDs), 0)

	plan.AddWordId(id1)
	plan.AddWordId(id2)
	assert.Equal(t, len(plan.WordIDs), 2)
	plan.DeleteWordId(id1)
	assert.Equal(t, len(plan.WordIDs), 1)
}