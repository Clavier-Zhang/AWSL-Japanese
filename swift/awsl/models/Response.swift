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


struct HomeResponse : Codable {
    
    public init() {
        status = true
        
        message = ""
        
        finishedNum = 0
        
        progressingNum = 0
        
        currentBook = ""
        
        todayNewNum = 0
        
        todayScheduleNum = 0
        
    }
    
    var status: Bool
    
    var message: String
    
    var finishedNum: Int
    
    var progressingNum: Int
    
    var currentBook: String
    
    var todayNewNum: Int
    
    var todayScheduleNum: Int
    
    
}
