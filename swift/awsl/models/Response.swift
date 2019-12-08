//
//  Response.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation


struct Response : Codable {
    
    var status: Bool
    
    var message: String
    
    var user: User?
    
    var words: [Word]?
    
}

struct TaskResponse : Codable {
    
    var status: Bool
    
    var message: String
    
    var words: [Word]
    
    var newWordsCount: Int
    
}


struct HomeResponse : Codable {
    
    var status: Bool = true
    
    var message: String = ""
    
    var finishedWordCount: Int = -1
    
    var progressingWordCount: Int = -1
    
    var currentPlan: String = ""
    
    var currentPlanLeftWordCount: Int = -1
    
    var scheduledWordsCount: Int = -1
    
}

struct PlanListResponse : Codable {
    
    var status: Bool = true
    
    var message: String = ""
    
    var numOptions: [Int] = [Int]()
    
    var planOptions: [Plan] = [Plan]()
    
    var currentNumOption: Int = 0
    
    var currentPlanOption: Int = 0
    
}
