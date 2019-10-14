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

extension UIImage {
    
    func toCVPixelBuffer() -> CVPixelBuffer {
        // crop image
        let cgImage = self.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: 40, height: 40))

        
        let croppedImage = UIImage(cgImage: cgImage!)
        
 
        // UIImage -> CVPixelBuffer
        let pixelBuffer = croppedImage.pixelBufferGray(width: 32, height: 32)
        return pixelBuffer!
    }
    
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        if let cgImage = cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    
    // Resizes the image to width x height and converts it to a grayscale CVPixelBuffer
    func pixelBufferGray(width: Int, height: Int) -> CVPixelBuffer? {
        return _pixelBuffer(width: width, height: height,
                           pixelFormatType: kCVPixelFormatType_OneComponent8,
                           colorSpace: CGColorSpaceCreateDeviceGray(),
            alphaInfo: .none)
    }
    
    func _pixelBuffer(width: Int, height: Int, pixelFormatType: OSType,
                     colorSpace: CGColorSpace, alphaInfo: CGImageAlphaInfo) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         pixelFormatType,
                                         attrs as CFDictionary,
                                         &maybePixelBuffer)
        
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        
        guard let context = CGContext(data: pixelData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: colorSpace,
                                      bitmapInfo: alphaInfo.rawValue)
            else {
                return nil
        }
        
        UIGraphicsPushContext(context)
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        return pixelBuffer
    }
    
    

    
}



func getPixelColor(_ image:UIImage, _ point: CGPoint) -> UIColor {
    let cgImage : CGImage = image.cgImage!
    guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else {
        return UIColor.clear
    }
    let data = CFDataGetBytePtr(pixelData)!
    let x = Int(point.x)
    let y = Int(point.y)
    let index = Int(image.size.width) * y + x
    let expectedLengthA = Int(image.size.width * image.size.height)
    let expectedLengthGrayScale = 2 * expectedLengthA
    let expectedLengthRGB = 3 * expectedLengthA
    let expectedLengthRGBA = 4 * expectedLengthA
    
    print(expectedLengthA)
    
    let numBytes = CFDataGetLength(pixelData)
    print(numBytes)

    
    
    switch numBytes {
    case expectedLengthA:
        print("expectedLengthA")
        return UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(data[index])/255.0)
    case expectedLengthGrayScale:
        print("gray")
        return UIColor(white: CGFloat(data[2 * index]) / 255.0, alpha: CGFloat(data[2 * index + 1]) / 255.0)
    case expectedLengthRGB:
        print("A")
        return UIColor(red: CGFloat(data[3*index])/255.0, green: CGFloat(data[3*index+1])/255.0, blue: CGFloat(data[3*index+2])/255.0, alpha: 1.0)
    case expectedLengthRGBA:
        print("B")
        return UIColor(red: CGFloat(data[4*index])/255.0, green: CGFloat(data[4*index+1])/255.0, blue: CGFloat(data[4*index+2])/255.0, alpha: CGFloat(data[4*index+3])/255.0)
    default:
        print("C")
        // unsupported format
        return UIColor.clear
    }
    
    
}





extension UIImage{
    
    func toMatrix() -> [[Bool]] {
        
        if (cgImage?.bitsPerPixel != 32) {
            print("empty")
            return [[Bool]]()
        }
        
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData)
        let numberOfComponents = 4
        let width = self.cgImage!.width
        let offset = (width/20)%2 == 1 ? 4 : 0
        
        
        
        var matrix = [[Bool]]()
        
        for m in 0...Int(size.height*2)-1 {
            var row = [Bool]()
                    for n in 0...Int(self.cgImage!.width+offset-1) {
                        let pos = ((Int(self.cgImage!.width+offset) * m) + n) * numberOfComponents - offset * numberOfComponents
        //                print(pos)
                        
                        row.append(data![pos] != 0)
            }
            print(row)
            matrix.append(row)

        }
        return matrix
    }
     

}
