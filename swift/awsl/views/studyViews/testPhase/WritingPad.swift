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
    
    var isPen : Binding<Bool>
    
    var view : PKCanvasTestView
    
    init(isPen : Binding<Bool>) {
        self.isPen = isPen
        self.view = PKCanvasTestView(frame: CGRect(x: 0, y: 0, width: 700, height: 100), isPen: isPen)
    }
    
    func makeUIView(context: Context) -> PKCanvasTestView {
        return view
    }

    func updateUIView(_ view: PKCanvasTestView, context: Context) {
        self.view = view
    }
    
    func getImage() -> UIImage {
        view.backgroundColor = .black
        let result = view.toUIImage()
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return result
    }
    
    // For test
    func getImages() -> [UIImage] {
        return HandwritingRecognizer.splitText(uiimage: self.getImage())
    }
    
    func getText() -> String {
        return HandwritingRecognizer.hiragana(uiimage: self.getImage())
    }
    
    func clean() {
        view.drawing = PKDrawing()
    }
    
    func switchTool() {
        view.switchTool()
    }
    
}


class PKCanvasTestView: PKCanvasView, UIPencilInteractionDelegate {
    
    var currentTool = "PEN"
    
    var eraser = PKEraserTool(.vector)
    
    var pen = PKInkingTool(.pen, color: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
    
    var isPen : Binding<Bool>?
    
    init(frame: CGRect, isPen: Binding<Bool>) {
        super.init(frame: frame)
        
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        self.addInteraction(interaction)
        
        self.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        self.allowsFingerDrawing = false
        self.tool = self.pen
        
        self.isPen = isPen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        print("tap")
        switchTool()
    }
    
    func switchTool() {
        self.isPen!.wrappedValue.toggle()
        if self.isPen!.wrappedValue {
            self.tool = self.pen
        } else {
            self.tool = self.eraser
        }
    }

}
