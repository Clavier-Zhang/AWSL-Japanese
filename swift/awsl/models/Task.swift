//
//  Task.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Word: Codable {
    
    struct Example: Codable {
        
        let japanese: String
        
        let translation: String
        
    }
    
    let text: String
    
    let furigara: String
    
    let en_meanings: [String]
    
    let en_examples: [Example]
    
    let cn_type: String
    
    let cn_meanings: [String]
    
    let cn_examples: [Example]
    
    let audio: Data
     
}



