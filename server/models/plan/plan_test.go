package plan

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
	"github.com/stretchr/testify/assert"
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