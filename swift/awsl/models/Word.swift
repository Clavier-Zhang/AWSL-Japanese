//
//  Word.swift
//  awsl
//
//  Created by clavier on 2019-10-09.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Word: Codable {
    
    init() {

        text = ""
        
        furigara = ""
        
        en_meanings = [String]()
        
        en_examples = [Example]()
        
        cn_type = ""
        
        cn_meanings = [String]()
        
        cn_examples = [Example]()
        
        audio = Data()
    }
    
    // From server
    
    let text: String
    
    let furigara: String
    
    let en_meanings: [String]
    
    let en_examples: [Example]
    
    let cn_type: String
    
    let cn_meanings: [String]
    
    let cn_examples: [Example]
    
    var audio: Data
    
    // Submit to server
    
    var status: String? = NEW
    
    var remainRepetition: Int? = 1
    
    var reviewCount: Int? = 0
    
    var isCorrect: Bool? = true
     
}

struct Example: Codable {
    
    let japanese: String
    
    let translation: String
    
}
