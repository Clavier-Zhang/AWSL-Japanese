//
//  Settings.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Settings : Codable {
    
    var isCN : Bool = LANGUAGE == "zh"
    
    var isHandwriting : Bool = false
    
    var isHiragana : Bool = true
    
    var isGrid : Bool = true
    
    static func get() -> Settings {
        var settings : Settings? = Local.get(key: "settings")
        if let settings = settings {
            return settings
        }
        settings = Settings()
        return settings!
    }
    
    func save() {
        Local.save(key: "settings", obj: self)
    }
    
    static func delete() {
        Local.remove(key: "settings")
    }
    
//    func isHandwriting() -> Bool {
//        return modeOptions[choosedMode] == "手写"
//    }
    
}
