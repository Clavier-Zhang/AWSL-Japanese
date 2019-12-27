package session

import (
	//"go.mongodb.org/mongo-driver/bson/primitive"
	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"

	_"log"
	_ "server/utils"

	//"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
	."server/models/plan"
)

func Test_Save_Find_Delete(t *testing.T) {
	email := "test@gmail.com"
	session := NewSession(email)
	id := session.ID
	session.Delete()

	assert.Nil(t, FindSessionByEmail(email))
	session.Save()

	session = FindSessionByEmail(email)
	assert.NotNil(t, session)
	assert.Equal(t, session.ID, id)
	assert.Empty(t, session.Cards["test"])

	session.ScheduledWordCount = 100
	session.Save()
	session = FindSessionByEmail(email)
	assert.Equal(t, session.ID, id)
	assert.Equal(t, session.ScheduledWordCount, 100)

	session.Delete()
	assert.Nil(t, FindSessionByEmail(email))
	session.Delete()
}

func Test_Add_Card(t *testing.T) {
	email := "test@gmail.com"
	session := NewSession(email)

	id1 := primitive.NewObjectID()
	id2 := primitive.NewObjectID()
	session.AddCard(id1)
	session.AddCard(id2)
	assert.NotNil(t, session.Cards[id1.Hex()])
	assert.NotNil(t, session.Cards[id2.Hex()])
	assert.Equal(t, session.Cards[id1.Hex()].WordID, id1)
}

func Test_Get_Review_Word_Ids(t *testing.T) {
	email := "test@gmail.com"
	session := NewSession(email)

	id1 := primitive.NewObjectID()
	id2 := primitive.NewObjectID()
	id3 := primitive.NewObjectID()
	session.AddCard(id1)
	session.AddCard(id2)
	session.AddCard(id3)

	session.SetCardLastReviewDate(id1, 20190620)
	session.SetCardLevel(id1, 1)

	session.SetCardLevel(id2, 2)
	session.SetCardLastReviewDate(id2, 20190620)

	session.SetCardLevel(id3, 3)
	session.SetCardLastReviewDate(id3, 20190620)

	wordIds := session.GetReviewWordIds(20190627)

	assert.Equal(t, len(wordIds), 2)
	//
	assert.Equal(t, wordIds[0], id1)
	assert.Equal(t, wordIds[1], id2)
}


func Test_Get_New_Word_From_Plan(t *testing.T) {
	email := "test@gmail.com"
	session := NewSession(email)

	id1 := primitive.NewObjectID()
	id2 := primitive.NewObjectID()
	id3 := primitive.NewObjectID()
	id4 := primitive.NewObjectID()
	session.AddCard(id1)
	session.AddCard(id2)

	plan := NewPlan("test_plan", "admin")
	plan.AddWordId(id1)
	plan.AddWordId(id2)
	plan.AddWordId(id3)
	plan.AddWordId(id4)

	ids := session.GetNewWordIdsFromPlan(plan)
	assert.Equal(t, len(ids), 2)
	//assert.Equal(t, ids[0], id3)
	//assert.Equal(t, ids[1], id4)


}