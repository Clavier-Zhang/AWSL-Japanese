//
//  User.swift
//  awsl
//
//  Created by clavier on 2019-10-04.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation


struct User: Codable {
    
    let email: String
    
    let password: String
    
    let token: String = ""
    
    public func toData() -> Data {
        let data = try! JSONEncoder().encode(self)
        return data
    }
    
}
