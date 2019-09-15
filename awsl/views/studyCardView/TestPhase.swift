//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import UIKit
import PencilKit


struct TestPhase: View {
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("Explanation")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120, alignment: .top)
                .background(base)
            

  
//            Spacer().frame(height: 600)
            
            ActivityIndicator()
//            Text("start")
            ProfileSwiftUIView().border(Color.white)
//            Text("end")
//            PKCanvasView()
//            ViewControllerWrapper()
//            DrawingViewController()
//            PKCanvasView()
            
            HStack {
                Spacer().frame(width: 20)
                Text("不认识")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .bottomLeading)
            .background(base)
            

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}
