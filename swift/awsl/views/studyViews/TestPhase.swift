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
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    @State var writingPad = WritingPadWrapper()
    
    var canvas : WritingPad = WritingPad()
    
    @State var label: String = "123"
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            MeaningRow(meanings: task.getWord().cn_meanings)
            
            // Buttons
            HStack {
                
                WideButton(label: "提交", action: pressSubmit, center: true)
                
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
                
            }
            
            // Recognized text
            Text(label)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .padding()
                .background(base)
        
            
            // Writing pad
            canvas.frame(width: 700, height: 200)

            // Instructions
                Text("在上方区域写出假名")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        print("submit")
        let res = HandwritingRecognizer.hiragana(uiimage: self.canvas.getImage())
        self.label = res
        print(res)


        
    }
    
    func pressUnableToSpell() {
        print("spell fail")
        self.currentPhase = "LEARN"
    }
}


