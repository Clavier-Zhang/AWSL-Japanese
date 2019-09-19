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
import Foundation

class PencilInteractionDelegate: NSObject, UIPencilInteractionDelegate {
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        if UIPencilInteraction.preferredTapAction == .switchPrevious {
            print("123333")
        }
    }
    
}

final class WritingPad : NSObject, UIViewRepresentable, UIPencilInteractionDelegate  {
    
    var view = PKCanvasViewWrapper()
    
    var eraser = PKEraserTool(.vector)
    
    var pen = PKInkingTool(.pen)
    
    var currentTool = "PEN"
    
    func makeUIView(context: Context) -> PKCanvasViewWrapper {
        
        view.allowsFingerDrawing = false
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        view.addInteraction(interaction)
        
//        view.parent = self
        return view
    }

    func updateUIView(_ view: PKCanvasViewWrapper, context: Context) {
    }
    
    func getDrawing() -> PKDrawing {
        return view.drawing
    }
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        print("jjjjjjj")
        if (self.currentTool == "PEN") {
            view.tool = self.eraser
            currentTool = "ERASER"
        } else {
            view.tool = self.pen
            currentTool = "PEN"
        }
    }
    
}


class PKCanvasViewWrapper : PKCanvasView {
    
    var parent : WritingPad?
    
    var count = 0
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        print(self.drawing)
//    }
    
    
}
