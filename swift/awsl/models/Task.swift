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
    
    init(words: [Word], date: Int, newCount: Int, isSubmitted: Bool) {
        self.newCount = newCount
        self.date = date
        self.newWords = words
        self.isSubmitted = isSubmitted
        for i in 0..<self.newWords.count {
            self.newWords[i].isCorrect = true
            self.newWords[i].status = NEW
            self.newWords[i].remainRepetition = 1
            self.newWords[i].reviewCount = 0
        }
        self.totalCount = newWords.count
        if isSubmitted {
            finishedWords = newWords
            newWords = []
        }
    }
    
    var totalCount: Int
    
    var newCount: Int
    
    var finishedWords: [Word] = [Word]()
    
    var newWords: [Word] = [Word]()
    
    var date: Int
    
    var studyTime: Int = 0
    
    var isSubmitted: Bool = false
    
    // HomeView
    func getScheduledCount() -> Int {
        return newWords.count+finishedWords.count
    }
    
    func getTotalCount() -> Int {
        return totalCount
    }
    
    func getNewCount() -> Int {
        return newCount
    }
    
    func getRemainCount() -> Int {
        return totalCount - finishedWords.count
    }
    
    // StudyCardView
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
            return Word(ID: Data(), text: "", label: "", english_meanings: [], english_examples: [], chinese_type: "", chinese_meanings: [], chinese_examples: [], audio: Data(), romaji: "")
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
        
        save()
        
    }
    
    static func get() -> Task {
        let task: Task? = Local.get(key: "task")
        if let task = task {
            return task
        }
        return Task(words: [Word](), date: 0, newCount: 0, isSubmitted: false)
    }
    
    static func delete() {
        Task(words: [Word](), date: 0, newCount: 0, isSubmitted: false).save()
    }
    
    func save() {
        Local.save(key: "task", obj: self)
    }
    
    func isValid() -> Bool {
        let today = Date().toNum()
        return date == today
    }
    
    func getTime() -> String {
        let hours = studyTime / 3600
        let minutes = (studyTime % 3600) / 60
//        let seconds = studyTime % 3600 % 60
        return String(hours) + " 小时 " + String(minutes) + " 分 "
    }
    
    mutating func getTopReviewWords(count: Int) -> [Word] {
        var copy = [Word](finishedWords)
        copy.sort(by: { $0.reviewCount! > $1.reviewCount! })
        let upper = min(count, copy.count)
        return Array(copy[..<upper])
    }

    
}

