//
//  constants.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

let LANGUAGE = Locale.preferredLanguages[0].prefix(2)

let UICOLOR_LIGHT_GRAY = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)

let UICOLOR_WHITE = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)

let LEARN_PHASE = "LEARN_PHASE"

var green = Color.init(red: 0x00/255, green: 0xa8/255, blue: 0x78/255)

var red = Color.init(red: 0x91/255, green: 0x1/255, blue: 0x1b/255)

var yellow = Color.init(red: 0xfc/255, green: 0xbd/255, blue: 0x00/255)

var base = Color.init(red: 30/255, green: 30/255, blue: 30/255)

var studyCardBase = Color.init(red: 20/255, green: 20/255, blue: 20/255)

var fullWidth = UIScreen.main.bounds.width

var fullHeight = UIScreen.main.bounds.height

var fontBase = Color.init(red: 0xe5/255, green: 0xe3/255, blue: 0xd1/255)

var baseURL = "http://192.168.31.158:8000/api"

var large = Font.system(size: 20)

var FONT_SMALL = Font.system(size: 14)

let SELF_EVALUATION_PHASE = "SELF_EVALUATION_PHASE"

let TEST_PHASE = "TEST_PHASE"

let SUBMISSION_PHASE = "SUBMISSION_PHASE"

let TEST = "TEST"

let LEARN = "LEARN"
