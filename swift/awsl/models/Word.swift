//
//  Word.swift
//  awsl
//
//  Created by clavier on 2019-10-09.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Word: Codable {
    
//    init() {
//
//        _id = ""
//
//        text = ""
//
//        label = ""
//
//        english_meanings = [String]()
//
//        english_examples = [Example]()
//
//        chinese_type = ""
//
//        chinese_meanings = [String]()
//
//        chinese_examples = [Example]()
//
//        audio = Data()
//    }
    
    // From server
    
    let ID: Data
    
    let text: String
    
    let label: String
    
    let english_meanings: [String]
    
    let english_examples: [Example]
    
    let chinese_type: String
    
    let chinese_meanings: [String]
    
    let chinese_examples: [Example]
    
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
