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

final class WritingPad : NSObject, UIViewRepresentable, UIPencilInteractionDelegate {
    
    var view = PKCanvasView()
    
    // Tools
    var currentTool = "PEN"
    var eraser = PKEraserTool(.vector)
    var pen = PKInkingTool(.pen, color: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
    
    func makeUIView(context: Context) -> PKCanvasView {
        currentTool = "PEN"
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        view.allowsFingerDrawing = false
        view.tool = self.pen
        // switch to eraser by double tap apple pencil
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        view.addInteraction(interaction)
        return view
    }

    func updateUIView(_ view: PKCanvasView, context: Context) {
    }
    
    func getImage() -> UIImage {
        view.backgroundColor = .black
        let result = view.toUIImage()
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return result
    }
    
    func getImages() -> [UIImage] {
        let uiimage = self.getImage()
        return HandwritingRecognizer.splitText(uiimage: uiimage)
    }
    
    func getText() -> String {
        return HandwritingRecognizer.hiragana(uiimage: self.getImage())
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
