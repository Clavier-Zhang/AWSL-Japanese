//
//  Task.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Task: Codable {
    
    public init(words: [Word]) {
        self.date = Date()
        self.finishedCardPairs = [CardPair]()
        self.newCardPairs = [CardPair]()
        for word in words {
            self.newCardPairs.append(CardPair(word))
        }
    }
    
    var date: Date
    
    var newCardPairs: [CardPair]
    
    var finishedCardPairs: [CardPair]
    
    public func getNewNum() -> Int {
        return newCardPairs.filter( {$0.card.status == "NEW" }).count
    }
    
    public func getProgressingNum() -> Int {
        return newCardPairs.filter( {$0.card.status == "PROGRESSING" }).count
    }
    
    public func getFinishedNum() -> Int {
        return finishedCardPairs.count
    }
    
    public func getWord() -> Word {
        return newCardPairs[0].word
    }
    
}


struct Card: Codable {
    
    public init() {
        self.status = "NEW"
        self.responseQuality = 5
        self.remainRepetition = 1
    }
    
    var responseQuality: Int
    
    var status: String
    
    var remainRepetition: Int
    
    
}

struct CardPair: Codable {
    
    public init(_ word: Word) {
        self.word = word
        self.card = Card()
    }
    
    var word: Word
    
    var card: Card
    
}
