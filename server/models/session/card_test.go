package session

import (
	//"go.mongodb.org/mongo-driver/bson/primitive"
	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"testing"
)

func Test_Date(t *testing.T) {

	assert.Equal(t, GetDateGap(20190615, 20190612), 3)
	assert.Equal(t, GetDateGap(20190612, 20190615), -3)
	assert.Equal(t, GetDateGap(20190615, 20190615), 0)
	assert.Equal(t, GetDateGap(20190615, 20190715), -30)
	assert.Equal(t, GetDateGap(20190915, 20190715), 62)
	assert.True(t, GetToday() >= 20191107)

}

func Test_Get_Interval(t *testing.T) {

	card := NewCard(primitive.NewObjectID())
	card.LastReviewDate = 20190615
	assert.Equal(t, card.GetInterval(), 1)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190615), 1)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190616), 0)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190617), -1)
	card.Level = 2
	assert.Equal(t, card.GetInterval(), 6)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190617), 4)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190620), 1)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190621), 0)
	assert.Equal(t, card.GetRemainDaysForNextReview(20190629), -8)
	card.Level = 3
	assert.Equal(t, card.GetInterval(), 15)
	card.Level = 4
	assert.Equal(t, card.GetInterval(), 37)
	card.Level = 5
	assert.Equal(t, card.GetInterval(), 93)

	card.EF = 2
	card.LastReviewDate = 0
	assert.Equal(t, card.GetRemainDaysForNextReview(20190629), -106703)

	card.Level = 3
	assert.Equal(t, card.GetInterval(), 12)
	card.Level = 4
	assert.Equal(t, card.GetInterval(), 24)
	card.Level = 5
	assert.Equal(t, card.GetInterval(), 48)
	card.Level = 6
	assert.Equal(t, card.GetInterval(), 96)


}

func Test_ReceiveResponseQuality(t *testing.T) {

	today := GetToday()

	// Easy
	card := NewCard(primitive.NewObjectID())
	card.ReceiveResponseQuality(0, today)
	assert.True(t, card.GetInterval() >= 10)
	assert.Equal(t, card.EF, 2.5)
	assert.Equal(t, card.LastReviewDate, today)

	// Correct
	card = NewCard(primitive.NewObjectID())
	card.ReceiveResponseQuality(1, today)
	assert.Equal(t, card.EF, 2.5)
	assert.Equal(t, card.Level, 2)

	card = NewCard(primitive.NewObjectID())
	card.ReceiveResponseQuality(4, today)
	assert.Equal(t, card.EF, 2.5)
	assert.Equal(t, card.Level, 1)

	card = NewCard(primitive.NewObjectID())
	card.ReceiveResponseQuality(5, today)
	assert.Equal(t, card.EF, 2.36)
	assert.Equal(t, card.Level, 1)

}