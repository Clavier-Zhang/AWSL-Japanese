package user

import (
	"github.com/stretchr/testify/assert"
	"testing"
)


func Test_New_Save_Delete_User(t *testing.T) {
	email := "TEST+93216489619824@gmail.com"
	user := NewUser(email, "111111")
	user.Email = email
	user.Save()
	user = FindUserByEmail(email)
	assert.NotNil(t, user)

	user.Delete()
	user = FindUserByEmail(email)
	assert.Nil(t, user)



}


