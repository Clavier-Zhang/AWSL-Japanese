//
//  Report.swift
//  awsl
//
//  Created by clavier on 2019-11-30.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Report : Codable {
    
    init(task: Task) {
        date = task.date
        studyTime = task.studyTime
        reportCards = [ReportCard]()
        for word in task.finishedWords {
            let card = ReportCard(
                ID: word.ID,
                reviewCount: word.reviewCount!
            )
            reportCards.append(card)
        }
    }
    
    var date: Int
    
    var tests: [String] = [String]()
    
    var studyTime: Int
    
    var reportCards: [ReportCard]
    
}


struct ReportCard : Codable {
    
    let ID: Data
    
    var reviewCount: Int
    
}
