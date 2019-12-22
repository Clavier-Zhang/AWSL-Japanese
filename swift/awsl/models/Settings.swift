//
//  Settings.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation

struct Settings : Codable {
    
    var languageOptions : [String] = ["中文", "English"]
    
    var choosedLanguage : Int = 0
    
    var modeOptions : [String] = ["手写", "键盘"]
    
    var choosedMode : Int = 0
    
    static func get() -> Settings {
        var settings : Settings? = Local.get(key: "settings")
        if let settings = settings {
            return settings
        }
        settings = Settings()
        settings!.save()
        return settings!
    }
    
    func save() {
        Local.save(key: "settings", obj: self)
    }
    
    func isHandwriting() -> Bool {
        return modeOptions[choosedMode] == "手写"
    }
}
