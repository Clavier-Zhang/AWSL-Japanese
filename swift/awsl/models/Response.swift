//
//  Response.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation


struct LoginResponse : Decodable {
    
    var status: Bool
    
    var message: String
    
    var user: User?
    
}
