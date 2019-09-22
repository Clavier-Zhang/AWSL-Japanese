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


final class WritingPad : NSObject, UIViewRepresentable, UIPencilInteractionDelegate  {
    
    var view : PKCanvasView
    
    var eraser = PKEraserTool(.vector)
    
    var pen : PKInkingTool
    
    var currentTool = "PEN"
    
    override init() {
//        super.init()
        self.view = PKCanvasView()
        self.pen = PKInkingTool(.pen)
        self.pen.color = .white
        view.tool = self.pen
        currentTool = "PEN"
        
        
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        view.allowsFingerDrawing = false
//        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)

        
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

