//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import UIKit
import PencilKit
import VideoToolbox


struct TestPhase: View {
    
    @State var uiimage : UIImage = UIImage()
    
    @State var pixelBufferImage : UIImage = UIImage()
    
    @Binding var currentPhase : String
    
    var canvas : WritingPad = WritingPad()
    
    var body: some View {
        VStack {
            
            // Explanation of the word
            HStack {
                Spacer()
                    .frame(width: 20)
                Text("【形容动词/ナ形容词】\n 1.好，高明，擅长，善于，拿手，能手。\n 2.善于奉承，会说话。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
                .background(base)
            
            // DEBUG
            // UIImage retrived from WritingBoard
//            Image(uiImage: uiimage)
//                .frame(width: 700, height: 100)
            
            // DEBUG
            // UIImage retrived from CVPixelBuffer
//            Image(uiImage: pixelBufferImage)
//                .frame(width: 700, height: 100)
            
            // Button Group
            HStack {
                Button(action:  {
                    
                    let hira = HandwritingRecognizer.hiragana(uiimage: self.canvas.getImage())
                    
                    print(hira)
                    
                }) {
                    Text("提交")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
    
                Button(action:  {
                    
                }) {
                    Text("不会拼")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
            

            // WritingBoard
            canvas.frame(width: 700, height: 200)
            
            // Instructions
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.white)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}


extension UIImage {
    
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


