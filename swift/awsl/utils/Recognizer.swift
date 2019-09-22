//
//  Recognizer.swift
//  awsl
//
//  Created by clavier on 2019-09-21.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


class HandwritingRecognizer {
    
    // UIImage -> Hiragana Label
    public static func hiragana(uiimage: UIImage) -> String? {
        // crop image
        let cgImage = uiimage.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: 200, height: 200))
        let croppedImage = UIImage(cgImage: cgImage!)
                            
        // UIImage -> CVPixelBuffer
        let pixelBuffer = croppedImage.pixelBufferGray(width: 32, height: 32)
                            
        // CVPixelBuffer -> Hirakana Label
        let model = hiraganaModel()
        let output = try? model.prediction(image: pixelBuffer!)
        if let output = output {
            return output.classLabel
        }
        return nil
    }

}
