//
//  User.swift
//  awsl
//
//  Created by clavier on 2019-10-04.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation


struct User: Codable {
    
    var email: String
    
    var password: String
    
    var token: String
    
    static func get() -> User {
        var user : User? = Local.get(key: "user")
        if let user = user {
            return user
        }
        user = User(email: "", password: "", token: "")
        user!.save()
        return user!
    }
    
    func save() {
        Local.save(key: "user", obj: self)
    }
    
    func isValid() -> Bool {
        return email != "" && token != ""
    }
    
    static func delete() {
        let user = User(email: "", password: "", token: "")
        user.save()
    }
    
}
