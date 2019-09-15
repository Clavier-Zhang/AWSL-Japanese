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

struct ProfileSwiftUIView: UIViewRepresentable {
//    let user: User

    func makeUIView(context: Context) -> PKCanvasView {
        return PKCanvasView()
    }

    func updateUIView(_ view: PKCanvasView, context: Context) {
//        view.nameLabel.text = user.name
//        view.imageView.image = user.image
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        

        return v
    }

    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
    
}
