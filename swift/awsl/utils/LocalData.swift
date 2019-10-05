//
//  LocalData.swift
//  awsl
//
//  Created by clavier on 2019-10-05.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation



struct Local {
    
    public static func save(key: String, obj: Any) {
        let defaults = UserDefaults.standard
        // Store
        defaults.set(obj, forKey: key)
    }
    
    public static func get(key: String) -> Data? {
        let defaults = UserDefaults.standard
        if let obj = defaults.data(forKey: key) {
            return obj
        }
        return nil
    }
    
    public static func exist(key: String) -> Bool {
        let defaults = UserDefaults.standard
        if let obj = defaults.object(forKey: key)
        {
            return true
        }
        return false
    }
    
    public static func remove(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
}


func dataToObj<T: Decodable>(data: Data) -> T? {
    let res = try? JSONDecoder().decode(T.self, from: data)
    if let res = res {
        return res
    }
    return nil
}
