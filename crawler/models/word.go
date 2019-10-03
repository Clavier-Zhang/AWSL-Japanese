package models

type Word struct {

	Text string `json:"text"`

	Furigara string `json:"furigara"`

	EN_Meanings []string `json:"en_meanings"`

	EN_Examples []Example `json:"en_examples"`

	CN_Type string `json:"cn_type"`

	CN_Meanings []string `json:"cn_meanings"`

	CN_Examples []Example `json:"cn_examples"`

	Audio []byte `json:"audio"`

}

type Example struct {

	Japanese string `json:"japanese"`

	Translation string `json:"translation"`

}


// Constructor for Example
func NewExample() *Example {
	example := &Example{}
	example.Translation = ""
	example.Japanese = ""
	return example
}


// Constructor for Word
func NewWord() *Word {
	word := &Word{}
	word.Text = ""
	word.Furigara = ""
	word.EN_Meanings = []string{}
	word.EN_Examples = []Example{}
	word.CN_Type = ""
	word.CN_Meanings = []string{}
	word.CN_Examples = []Example{}
	word.Audio = []byte{}
	return word
}
