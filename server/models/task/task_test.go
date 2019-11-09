package task


import (
	//"github.com/stretchr/testify/assert"

	"github.com/stretchr/testify/assert"
	//"go.mongodb.org/mongo-driver/bson/primitive"
	."server/models/plan"
	."server/models/session"
	//"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
)

func Test_New_Task(t *testing.T) {

	plan := NewPlan("test_plan", "admin")
	session := NewSession("test@gmail.com")
	id1 := primitive.NewObjectID()
	id2 := primitive.NewObjectID()
	id3 := primitive.NewObjectID()
	id4 := primitive.NewObjectID()

	plan.AddWordId(id1)
	plan.AddWordId(id2)
	plan.AddWordId(id3)
	plan.AddWordId(id4)


	session.AddCard(id1)
	session.SetCardLastReviewDate(id1, 20190612)
	session.AddCard(id2)
	session.SetCardLastReviewDate(id2, 20190612)


	// No review words
	session.ScheduledWordCount = 2
	task := NewTask(session, plan, 20190613)
	assert.Equal(t, len(task.Records), 2)
	assert.NotEmpty(t, task.Records[id1.Hex()])
	assert.NotEmpty(t, task.Records[id2.Hex()])

	session.ScheduledWordCount = 4
	task = NewTask(session, plan, 20190613)
	assert.Equal(t, len(task.Records), 4)
	assert.NotEmpty(t, task.Records[id1.Hex()])
	assert.NotEmpty(t, task.Records[id2.Hex()])
	assert.NotEmpty(t, task.Records[id3.Hex()])
	assert.NotEmpty(t, task.Records[id4.Hex()])

	session.ScheduledWordCount = 6
	task = NewTask(session, plan, 20190613)
	assert.Equal(t, len(task.Records), 4)
	assert.NotEmpty(t, task.Records[id1.Hex()])
	assert.NotEmpty(t, task.Records[id2.Hex()])
	assert.NotEmpty(t, task.Records[id3.Hex()])
	assert.NotEmpty(t, task.Records[id4.Hex()])

}
