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


extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}



func pixelBufferFromImage(uiimage: UIImage) -> CVPixelBuffer {
    
//        var image = uiimage.rotate(radians: )
        var image = uiimage
        
        let ciimage = CIImage(image: image)
        //let cgimage = convertCIImageToCGImage(inputImage: ciimage!)
        let tmpcontext = CIContext(options: nil)
        let cgimage =  tmpcontext.createCGImage(ciimage!, from: ciimage!.extent)
        
        let cfnumPointer = UnsafeMutablePointer<UnsafeRawPointer>.allocate(capacity: 1)
        let cfnum = CFNumberCreate(kCFAllocatorDefault, .intType, cfnumPointer)
        let keys: [CFString] = [kCVPixelBufferCGImageCompatibilityKey, kCVPixelBufferCGBitmapContextCompatibilityKey, kCVPixelBufferBytesPerRowAlignmentKey]
        let values: [CFTypeRef] = [kCFBooleanTrue, kCFBooleanTrue, cfnum!]
        let keysPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
        let valuesPointer =  UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
        keysPointer.initialize(to: keys)
        valuesPointer.initialize(to: values)
        
        let options = CFDictionaryCreate(kCFAllocatorDefault, keysPointer, valuesPointer, keys.count, nil, nil)
       
        let width = cgimage!.width
        let height = cgimage!.height
     
        var pxbuffer: CVPixelBuffer?
        var status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                         kCVPixelFormatType_32BGRA, options, &pxbuffer)
//    var status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
//    kCVPixelFormatType_OneComponent8, options, &pxbuffer)
    
        status = CVPixelBufferLockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
        
        let bufferAddress = CVPixelBufferGetBaseAddress(pxbuffer!);

        
//        let rgbColorSpace = CGColorSpaceCreateDeviceGray()
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()

        let bytesperrow = CVPixelBufferGetBytesPerRow(pxbuffer!)
        let context = CGContext(data: bufferAddress,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesperrow,
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue);
    

        context?.concatenate(__CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, CGFloat(width), 0.0)) //Flip Horizontal
        

        context?.draw(cgimage!, in: CGRect(x:0, y:0, width:CGFloat(width), height:CGFloat(height)));
        status = CVPixelBufferUnlockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
        return pxbuffer!;
        
    }






struct TestPhase: View {
    
    @State var uiimage : UIImage = UIImage()
    
    @State var test : UIImage = UIImage()
    
    @Binding var currentPhase : String
    
    var canvas : WritingPad = WritingPad()
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("【形容动词/ナ形容词】\n 1.好，高明，擅长，善于，拿手，能手。\n 2.善于奉承，会说话。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
                .background(base)
            
//             For test, show image
            Image(uiImage: uiimage)
                .frame(width: 700, height: 100)
            
            Image(uiImage: test)
                .frame(width: 700, height: 100)
            
            
            HStack {
                
                Button(action:  {
                    
                    let resultImage = self.canvas.getImage()
                    var temp = resultImage.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: 200, height: 200))
                    
                    if let temp = temp {
                        print("hhh")
                        self.uiimage = UIImage(cgImage: temp)
                    }
                    
//                    self.test = resultImage
                    
                    
                    let pixelBuffer = self.uiimage.pixelBufferGray(width: 32, height: 32)
                    
//                    let source = UIImage.init(data: self.canvas.getDrawing().dataRepresentation())
                    
//                    let source = self.canvas.getDrawing().image(from: CGRect(x: 0, y: 0, width: 200, height: 200) ,scale: 3.0).withHorizontallyFlippedOrientation()
//
//
//                    self.uiimage = source
//
                    // resize
//                    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 32, height: 32))
//
//                    self.uiimage = renderer.image { (context) in
//                        self.uiimage.draw(in: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
//                    }
//
//
//                    let pixelbuffer = pixelBufferFromImage(uiimage: self.uiimage)
//
//
//
                    let temp2 = UIImage(pixelBuffer: pixelBuffer!)
                    self.test = temp2!
//
//
//                    print("ta[")
//
//                    let model = hiraganaModel()
//
//                    let output = try? model.prediction(image: pixelbuffer)
//                    print(output?.classLabel)
                    
                    
                    
                    let model = hiraganaModel()
                    // output a Hiragana character
                    let output = try? model.prediction(image: pixelBuffer!)
                    print(output?.classLabel)
                    
                }) {
                    Text("提交")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
                
                
                Button(action:  {
                    self.uiimage = self.canvas.getDrawing().image(from: CGRect(x: 0, y: 0, width: 700, height: 100) ,scale: 3.0)
                }) {
                    Text("不会拼")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
            

            
            canvas.frame(width: 700, height: 200)
//                .border(Color.white)
            
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


