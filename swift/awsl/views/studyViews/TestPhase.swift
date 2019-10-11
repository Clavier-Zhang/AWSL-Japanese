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
import VideoToolbox


struct TestPhase: View {
    
    @State var uiimage : UIImage = UIImage()
    
    @State var pixelBufferImage : UIImage = UIImage()
    
    @State var handwritingLabel : String = ""
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    var canvas : WritingPad = WritingPad()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            HStack {
                Spacer()
                    .frame(width: 20)
                Text("【形容动词/ナ形容词】\n 1.好，高明，擅长，善于，拿手，能手。\n 2.善于奉承，会说话。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
                .background(base)
            
            // Buttons
            HStack {
                
                WideButton(label: "提交", action: pressSubmit, center: true)
                
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
                
            }
            
            // Recognization of the hand-writing
            HStack {
                Spacer().frame(width: 20)
                Text(self.handwritingLabel)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)

            // WritingBoard
            canvas.frame(width: 700, height: 200)
            
            // Instructions
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.white)
            
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        print("submit")

        let hira = HandwritingRecognizer.hiragana(uiimage: self.canvas.getImage())
        self.handwritingLabel = hira
        print(hira)
        
    }
    
    func pressUnableToSpell() {
        print("spell fail")
        self.currentPhase = "LEARN"
    }
}


