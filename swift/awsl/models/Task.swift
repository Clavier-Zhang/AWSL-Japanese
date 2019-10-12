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
        self.finishedCards = [Card]()
        self.newCardPairs = [CardPair]()
        for word in words {
            self.newCardPairs.append(CardPair(word))
        }
    }
    
    var date: Date
    
    var newCardPairs: [CardPair]
    
    var finishedCards: [Card]
    
    public func getNewNum() -> Int {
        return newCardPairs.filter( {$0.card.status == "NEW" }).count
    }
    
    public func getReviewNum() -> Int {
        return newCardPairs.filter( {$0.card.status == "REVIEW" }).count
    }
    
    public func getFinishedNum() -> Int {
        return finishedCards.count
    }
    
    public func getWord() -> Word {
        return newCardPairs[0].word
    }
    
    public func getStatus() -> String {
        return newCardPairs[0].card.status
    }
    
    public func isEmpty() -> Bool {
        return newCardPairs.count == 0
    }
    
    mutating public func easy() {
        newCardPairs[0].card.easy = true
    }
    
    mutating public func next() {
        // Easy
        if (newCardPairs[0].card.easy) {
            var card = newCardPairs[0].card
            newCardPairs.remove(at: 0)
            card.easy = true
            finishedCards.append(card)
        }
        
    }
    
    
}


struct Card: Codable {
    
    public init() {
        self.status = "NEW"
        self.responseQuality = 5
        self.remainRepetition = 1
        self.failedTimes = 0
        self.easy = false
    }
    
    var responseQuality: Int
    
    var status: String
    
    var remainRepetition: Int
    
    var failedTimes: Int
    
    var easy: Bool
    
    
}

struct CardPair: Codable {
    
    public init(_ word: Word) {
        self.word = word
        self.card = Card()
    }
    
    var word: Word
    
    var card: Card
    
}
