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
    
    var status: Bool = true
    
    var message: String = ""
    
    var finishedNum: Int = -1
    
    var progressingNum: Int = -1
    
    var currentBook: String = ""
    
    var todayNewNum: Int = -1
    
    var todayScheduleNum: Int = -1
    
    
}
