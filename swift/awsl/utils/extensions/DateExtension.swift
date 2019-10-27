//
//  DateExtension.swift
//  awsl
//
//  Created by clavier on 2019-10-26.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

extension Date {
    
    func toNum() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDateString: String = dateFormatter.string(from: self)
        return Int(currentDateString)!
    }
}
