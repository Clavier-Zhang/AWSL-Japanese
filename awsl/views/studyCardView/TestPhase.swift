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
    
    @State var uiimage : UIImage = UIImage()

    
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
                .frame(width: 100, height: 100)
                .border(Color.white)
            
            Button(action:  {
//                print(self.drawing)
                }, label: {
                Text("test")
            })
            
//            Image(imageTest)
//                .frame(width: 100, height: 100)
//                .border(Color.white)

            WritingPad(uiimage: $uiimage)
                .border(Color.white)
//            WritingWrapper().border(Color.white)
                

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
