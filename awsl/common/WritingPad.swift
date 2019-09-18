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


struct WritingPad : UIViewRepresentable {
    
    var view = PKCanvasViewWrapper()
    
    func makeUIView(context: Context) -> PKCanvasViewWrapper {
        
        view.allowsFingerDrawing = false
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        view.parent = self
        return view
    }

    func updateUIView(_ view: PKCanvasViewWrapper, context: Context) {
    }
    
    func getDrawing() -> PKDrawing {
        return view.drawing
    }
    
}


class PKCanvasViewWrapper : PKCanvasView {
    
    var parent : WritingPad?
    
    var count = 0
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print(self.drawing)
//        self.parent?.helper()
//        self.parent?.uiimage = self.drawing.image(from: CGRect(x: 0, y: 0, width: 100, height: 100) ,scale: 3.0)
    }
    
    
}
