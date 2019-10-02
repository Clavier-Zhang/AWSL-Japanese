package models

type Word struct {

	Text string `json:"text"`

	Furigara string `json:"furigara"`

	EN_Meanings []string `json:"en_meanings"`

	EN_Examples []EN_Example `json:"en_examples"`

	CN_Type string `json:"cn_type"`

	CN_Meanings []string `json:"cn_meanings"`

	CN_Examples []CN_Example `json:"cn_examples"`

	Audio []byte `json:"audio"`

}

type EN_Example struct {

	Japanese string `json:"japanese"`

	Translation string `json:"translation"`

}

type CN_Example struct {

	Japanese string `json:"japanese"`

	Translation string `json:"translation"`

}