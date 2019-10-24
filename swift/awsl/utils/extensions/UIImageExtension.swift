//
//  UIImageExtension.swift
//  awsl
//
//  Created by clavier on 2019-10-23.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import UIKit
import PencilKit
import VideoToolbox
import CoreGraphics


extension UIImage{
    
    func toMatrix() -> [[Int]] {
        // If UIImage is empty
        if (cgImage?.bitsPerPixel != 32) {
            return [[Int]]()
        }
        // Get bytes
        let data = CFDataGetBytePtr(self.cgImage!.dataProvider!.data)!
        let bitsPerPoint = 4
        // Get width and height
        let width = Int(self.cgImage!.width)
        let height = Int(self.cgImage!.height)
        // Magic offset before at the head of bytes
        let offset = (width/20)%2 == 1 ? 4 : 0
        
        var matrix = [[Int]]()
        
        for row in 0...(height-1) {
            var temp = [Int]()
            for col in 0...(width-1) {
                let pos = (((width+offset) * row) + col) * bitsPerPoint
                temp.append(data[pos] == 0 ? 0 : 1)
            }
            print(temp)
            matrix.append(temp)
        }

        return matrix
    }
    
    
    
    
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


