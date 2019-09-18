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

class WritingPadStatus: ObservableObject  {
    
    @Published var count : Int = 0
    
    @Published var canvas: PKCanvasViewWrapper?
    
}


struct TestPhase: View {
    
    @State var uiimage : UIImage = UIImage()
    
    var test : WritingPad = WritingPad()
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("Explanation")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120, alignment: .top)
                .background(base)
            
            Image(uiImage: uiimage)
                .frame(width: 700, height: 100)
                .border(Color.white)
            
            Button(action:  {
                self.uiimage = self.test.getDrawing().image(from: CGRect(x: 0, y: 0, width: 700, height: 100) ,scale: 3.0)
                }, label: {
                Text("count")
            })
            
            test.frame(width: 700, height: 200)
                .border(Color.white)
            
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
