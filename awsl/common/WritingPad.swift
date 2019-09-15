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
    
    @Binding var uiimage : UIImage
    
    func makeUIView(context: Context) -> PKCanvasViewWrapper {
        let view = PKCanvasViewWrapper()
        view.allowsFingerDrawing = false
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        view.parent = self
        return view
    }

    func updateUIView(_ view: PKCanvasViewWrapper, context: Context) {
//        uiimage = view.uiimage
    }
    
    func helper() {
        print("hhhhh")
    }
    

    
    
    

}


class PKCanvasViewWrapper : PKCanvasView {
    
//    @State var test : UIImage = UIImage()
    
    var parent : WritingPad?
    
//    var uiimage : UIImage?
//
//    init(uiimage: inout UIImage) {
//        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        self.uiimage = uiimage
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("Touch")
        print(self.drawing)
        self.parent?.helper()
//        self.uiimage = self.drawing.image(from: CGRect(x: 0, y: 0, width: 100, height: 100) ,scale: 3.0)
    }
    
}
