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

class PKCanvasTestView: PKCanvasView, UIPencilInteractionDelegate {
    
    var currentTool = "PEN"
    
    var eraser = PKEraserTool(.vector)
    
    var pen = PKInkingTool(.pen, color: UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let interaction = UIPencilInteraction()
        interaction.delegate = self
        self.addInteraction(interaction)
        
        self.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        self.allowsFingerDrawing = false
        self.tool = self.pen
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func pencilInteractionDidTap(_ interaction: UIPencilInteraction) {
        print("tap")
        if (self.currentTool == "PEN") {
            self.tool = self.eraser
            currentTool = "ERASER"
        } else {
            self.tool = self.pen
            currentTool = "PEN"
        }
    }

}


final class WritingPad : NSObject, UIViewRepresentable, UIPencilInteractionDelegate {
    
    var view = PKCanvasTestView(frame: CGRect(x: 0, y: 0, width: 700, height: 100))
    
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
    
}



final class TestChart : NSObject, UIViewRepresentable, UIPencilInteractionDelegate {
    
    var view = UITableView()
    
    func makeUIView(context: Context) -> UITableView {
        return view
    }

    func updateUIView(_ view: UITableView, context: Context) {
        self.view = view
    }
   
}
