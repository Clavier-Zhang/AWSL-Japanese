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


struct ProfileSwiftUIView: UIViewRepresentable {
    
    var view = PKCanvasView()

    func makeUIView(context: Context) -> PKCanvasView {
        view.allowsFingerDrawing = false
        view.backgroundColor = UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        return view
    }

    func updateUIView(_ view: PKCanvasView, context: Context) {
        print(view.drawing)
    }
    
    
    

}

struct WritingWrapper : UIViewControllerRepresentable {
    
    var view = WritingController()
    
    func makeUIViewController(context: Context) -> WritingController {
        
        return view
    }

    func updateUIViewController(_ view: WritingController, context: Context) {
    //        print(view.drawing)
    }
    
    
}


class WritingController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScreenshotServiceDelegate {
    
    var writing : PKCanvasView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let frame = self.view.frame
//        let layout = UICollectionViewFlowLayout()
        
        writing = PKCanvasView()
        writing.backgroundColor = .red
        self.view.addSubview(writing)
        writing.translatesAutoresizingMaskIntoConstraints = false
        writing.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        writing.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        writing.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        writing.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("23333")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(333333)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            // ...
        }
        print("Touch")
        
    }
    
    /// Delegate method: Note that the drawing has changed.
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print(1)
    }
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print(2222222)
    }
  
    
    

}
