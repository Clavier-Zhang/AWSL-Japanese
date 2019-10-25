//
//  UIImageExtension.swift
//  awsl
//
//  Created by clavier on 2019-10-23.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

extension UIImage {
    
    func toUIImages(rects: [CGRect]) -> [UIImage] {
        var images = [UIImage]()
        for rect in rects {
            images.append(crop(rect))
        }
        return images
    }
    
    func crop(_ rect: CGRect) -> UIImage {
        return UIImage(cgImage: cgImage!.cropping(to: rect)!)
    }
    
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
        // Check all pixel to fill in matrix
        var matrix = [[Int]]()
        for row in 0...(height-1) {
            var temp = [Int]()
            for col in 0...(width-1) {
                let pos = (((width+offset) * row) + col) * bitsPerPoint
                temp.append(data[pos] == 0 ? 0 : 1)
            }
            matrix.append(temp)
        }
        return matrix
    }
    
    func toCVPixelBuffer() -> CVPixelBuffer {
        return self.pixelBufferGray(width: 32, height: 32)!
    }
    
    func pixelBufferGray(width: Int, height: Int) -> CVPixelBuffer? {
        return _pixelBuffer(width: width, height: height, pixelFormatType: kCVPixelFormatType_OneComponent8, colorSpace: CGColorSpaceCreateDeviceGray(), alphaInfo: .none)
    }
       
    func _pixelBuffer(width: Int, height: Int, pixelFormatType: OSType, colorSpace: CGColorSpace, alphaInfo: CGImageAlphaInfo) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                        kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, pixelFormatType, attrs as CFDictionary, &maybePixelBuffer)
           
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
           
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
           
        guard let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
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


