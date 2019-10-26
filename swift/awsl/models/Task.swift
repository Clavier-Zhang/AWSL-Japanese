//
//  Task.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation


let NEW = "NEW"
let REVIEW = "REVIEW"
let EASY = "EASY"
let DONE = "DONE"
let CORRECT = "CORRECT"
let WRONG = "WRONG"


struct Task: Codable {
    
    public init(words: [Word]) {
        for word in words {
            self.newCardPairs.append(CardPair(word))
        }
    }
    
    var date: Date = Date()
    
    var newCardPairs: [CardPair] = [CardPair]()
    
    var finishedCards: [Card] = [Card]()
    
    var studyTime: Int = 0
    
    public func getNewNum() -> Int {
        return newCardPairs.filter( {$0.card.status != REVIEW }).count
        
    }
    
    public func getReviewNum() -> Int {
        return newCardPairs.filter( {$0.card.status == REVIEW }).count
    }
    
    public func getFinishedNum() -> Int {
        return finishedCards.count
    }
    
    public func getWord() -> Word {
        if (isEmpty()) {
            return Word()
        }
        return newCardPairs[0].word
    }
    
    public func getStatus() -> String {
        return newCardPairs[0].card.status
    }
    
    public func isEmpty() -> Bool {
        return newCardPairs.count == 0
    }
    
    mutating public func setEasy() {
        newCardPairs[0].card.status = EASY
    }
    
    mutating public func setReview() {
        newCardPairs[0].card.status = REVIEW
    }
    
    mutating public func setDone() {
        newCardPairs[0].card.status = DONE
    }
    
    mutating public func setCorrect() {
        newCardPairs[0].card.isCorrect = true
    }
    
    mutating public func setWrong() {
        newCardPairs[0].card.isCorrect = false
    }
    
    mutating public func next() {
        print("next")
        
        var pair = newCardPairs[0]
        print(pair)
        
        newCardPairs.remove(at: 0)
        let upper = min(newCardPairs.count, 50)
        var random = Int.random(in: 0 ... upper)
        random = min(random+1, newCardPairs.count-1)
        // Easy
        if (pair.card.status == EASY) {
            finishedCards.append(pair.card)
        // Correct
        } else if (pair.card.isCorrect) {
            print("then correct")
            pair.card.remainRepetition -= 1
            pair.card.reviewCount += 1
            if (pair.card.remainRepetition == 0) {
                // finish
                finishedCards.append(pair.card)
            } else {
                // Keep review ****
                newCardPairs.insert(pair, at: random)
                
            }
        // Wrong
        } else if (!pair.card.isCorrect) {
            pair.card.remainRepetition = 3
            pair.card.status = REVIEW
            newCardPairs.insert(pair, at: random)
        }
        
    }
    
    
}


struct Card: Codable {
    
    var responseQuality: Int = 5
    
    var status: String = NEW
    
    var remainRepetition: Int = 1
    
    var reviewCount: Int = 0
    
    var isCorrect: Bool = true
    
}

struct CardPair: Codable {
    
    public init(_ word: Word) {
        self.word = word
        self.card = Card()
    }
    
    var word: Word
    
    var card: Card
    
}
