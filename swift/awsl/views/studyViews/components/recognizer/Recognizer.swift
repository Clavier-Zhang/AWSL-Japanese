//
//  Recognizer.swift
//  awsl
//
//  Created by clavier on 2019-09-21.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import UIKit
import PencilKit
import VideoToolbox
import CoreGraphics


class HandwritingRecognizer {
    
    // UIImage -> Hiragana Label
    public static func hiragana(uiimage: UIImage) -> String {
        // CVPixelBuffer -> Hirakana Label
        let model = hiraganaModel()
        let output = try? model.prediction(image: uiimage.toCVPixelBuffer())
        if let output = output {
            return output.classLabel
        }
        return ""
    }

}
