package task

import (
	//"bytes"
	"encoding/json"
	"go.mongodb.org/mongo-driver/bson/primitive"

	//"fmt"
	"io"
	//"log"
	//"server/utils"
	//"time"

	//"github.com/tidwall/gjson"
	//"io/ioutil"
	//"server/utils"
)

type Report struct {

	Date int `json:"date"`

	StudyTime int `json:"studyTime"`

	ReportCards []ReportCard `json:"reportCards"`

}

type ReportCard struct {

	ID primitive.ObjectID `json:"ID"`

	ReviewCount int `json:"reviewCount"`

}



func DecodeReport(body io.Reader) *Report {
	report := &Report{}
	err := json.NewDecoder(body).Decode(report)
	if err != nil {
		return nil
	}
	return report
}