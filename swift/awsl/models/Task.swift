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
let CORRECT = "CORRECT"
let WRONG = "WRONG"


struct Task: Codable {
    
    init(words: [Word], date: Int) {
        self.date = date
        self.newWords = words
    }
    
    var finishedWords: [Word] = [Word]()
    
    var newWords: [Word] = [Word]()
    
    var date: Int
    
    var studyTime: Int = 0
    
    var submitted: Bool = false
    
    func getNewNum() -> Int {
        return newWords.filter( {$0.status != REVIEW }).count
    }
    
    func getReviewNum() -> Int {
        return newWords.filter( {$0.status == REVIEW }).count
    }
    
    func getFinishedNum() -> Int {
        return finishedWords.count
    }
    
    func getWord() -> Word {
        if (isEmpty()) {
            return Word()
        }
        return newWords[0]
    }
    
    func getStatus() -> String {
        return newWords[0].status!
    }
    
    func isEmpty() -> Bool {
        return newWords.count == 0
    }
    
    mutating func setEasy() {
        newWords[0].status = EASY
    }
    
    mutating func setCorrect() {
        newWords[0].isCorrect = true
    }
    
    mutating func setWrong() {
        newWords[0].isCorrect = false
    }
    
    mutating func next() {

        if (isEmpty()) {
            return
        }
        
        var word = newWords[0]
        
        newWords.remove(at: 0)
        let upper = min(newWords.count, 50)
        var random = Int.random(in: 0 ... upper)
        random = min(random+1, newWords.count-1)
        // Easy
        if (word.status == EASY) {
            finishedWords.append(word)
        // Correct
        } else if (word.isCorrect!) {
            word.remainRepetition! -= 1
            word.reviewCount! += 1
            if (word.remainRepetition == 0) {
                // finish
                finishedWords.append(word)
            } else {
                // Keep review ****
                newWords.insert(word, at: random)
                
            }
        // Wrong
        } else if (!word.isCorrect!) {
            word.remainRepetition! = 3
            word.status! = REVIEW
            newWords.insert(word, at: random)
        }
        
        Local.save(key: "task", obj: self)
        
    }
    
    mutating func clearData() {
        for i in 0..<finishedWords.count {
            finishedWords[i].audio = Data()
        }
    }

    
}

