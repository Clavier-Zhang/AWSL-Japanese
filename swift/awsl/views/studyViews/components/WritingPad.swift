//
//  WritingPad.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import UIKit
import PencilKit
import SwiftUI




struct WritingPadWrapper: View {
    
    var canvas : WritingPad = WritingPad()
    
    @State var label: String = "123"

    var body: some View {
        VStack {
            // Recognization of the hand-writing
            HStack {
                Spacer().frame(width: 20)
                Text(label)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
//
//            // WritingBoard
            canvas.frame(width: 700, height: 200)

            // Instructions
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.white)
        }
    }
    
    public func recognize() -> String {
        self.label = "hhhhh"
        return HandwritingRecognizer.hiragana(uiimage: self.canvas.getImage())
    }
    
}







extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


final class WritingPad : NSObject, UIViewRepresentable, UIPencilInteractionDelegate {
    
    var view : PKCanvasView
    
    var eraser = PKEraserTool(.vector)
    
    var pen : PKInkingTool
    
    var currentTool = "PEN"
    
    override init() {
        self.view = PKCanvasView()
        self.pen = PKInkingTool(.pen)
        print("white")
        self.pen.color = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        view.tool = self.pen
        currentTool = "PEN"
        
        
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        view.allowsFingerDrawing = false
        // switch to eraser by double tap apple pencil
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        view.addInteraction(interaction)
        

        return view
    }

    func updateUIView(_ view: PKCanvasView, context: Context) {
    }
    
    func getDrawing() -> PKDrawing {
        return view.drawing
    }
    
    func getImage() -> UIImage {
        view.backgroundColor = .black
        let result = view.asImage()
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return result
    }
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        if (self.currentTool == "PEN") {
            view.tool = self.eraser
            currentTool = "ERASER"
        } else {
            view.tool = self.pen
            currentTool = "PEN"
        }
    }
    
    
    

}

