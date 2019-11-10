package word

import (
	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
)


func Test_Save_Delete_Find(t *testing.T) {

	text1 := "夜"
	label1 := "よる"
	text2 := "川"
	label2 := "かわ"


	word1 := NewWord(text1, label1)
	word2 := NewWord(text1, label2)
	word3 := NewWord(text2, label1)

	assert.NotEqual(t, word1.ID, primitive.ObjectID{})

	word1.Save()
	word2.Save()
	word3.Save()

	word1 = FindWordByTextAndLabel(text1, label1)
	assert.NotNil(t, word1)
	assert.Equal(t, word1.Text, text1)
	assert.Equal(t, word1.Label, label1)

	id := word1.ID
	word1.ChineseType = "noun"
	word1.Save()
	word1 = FindWordByTextAndLabel(text1, label1)

	assert.Equal(t, word1.ID, id)
	assert.Equal(t, word1.ChineseType, "noun")


}

