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
    
    var view : ExtendedPKCanvasView
    
    init(isPen : Binding<Bool>) {
        self.isPen = isPen
        self.view = ExtendedPKCanvasView(frame: CGRect(x: 0, y: 0, width: 700, height: 100), isPen: isPen)
    }
    
    func makeUIView(context: Context) -> ExtendedPKCanvasView {
        return view
    }

    func updateUIView(_ view: ExtendedPKCanvasView, context: Context) {
        self.view = view
    }
    
    func getImage() -> UIImage {
        view.backgroundColor = .black
        let result = view.toUIImage()
        view.backgroundColor = UICOLOR_LIGHT_GRAY
        return result
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
    
    // For test
    func getImages() -> [UIImage] {
        return HandwritingRecognizer.splitText(uiimage: self.getImage())
    }
    
}


class ExtendedPKCanvasView: PKCanvasView, UIPencilInteractionDelegate {
    
    var isPen : Binding<Bool>?
    
    init(frame: CGRect, isPen: Binding<Bool>) {
        super.init(frame: frame)
        self.isPen = isPen
        // Double tap
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        addInteraction(interaction)
        // Settings
        backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        allowsFingerDrawing = false
        tool = PKInkingTool(.pen, color: UICOLOR_WHITE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        switchTool()
    }
    
    func switchTool() {
        isPen!.wrappedValue.toggle()
        if isPen!.wrappedValue {
            tool = PKInkingTool(.pen, color: UICOLOR_WHITE)
        } else {
            tool = PKEraserTool(.vector)
        }
    }

}
