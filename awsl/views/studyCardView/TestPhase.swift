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
    
    var canvas : WritingPad = WritingPad()
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("【形容动词/ナ形容词】\n 1.好，高明，擅长，善于，拿手，能手。\n 2.善于奉承，会说话。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
                .background(base)
            
//             For test, show image
//            Image(uiImage: uiimage)
//                .frame(width: 700, height: 100)
            
            
            HStack {
                
                Button(action:  {
                    self.uiimage = self.canvas.getDrawing().image(from: CGRect(x: 0, y: 0, width: 700, height: 100) ,scale: 3.0)
                }) {
                    Text("提交")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
                
                
                Button(action:  {
                    self.uiimage = self.canvas.getDrawing().image(from: CGRect(x: 0, y: 0, width: 700, height: 100) ,scale: 3.0)
                }) {
                    Text("不会拼")
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .center)
                    .background(base)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
            

            
            canvas.frame(width: 700, height: 200)
//                .border(Color.white)
            
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.white)
            


        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}
