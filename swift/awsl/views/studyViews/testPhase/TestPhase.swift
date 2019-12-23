//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


struct TestPhase: View {
    
    @State var settings = Settings.get()
    
    @State var isCorrect = true
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    var canvas : WritingPad = WritingPad()
    
    @State var label: String = ""
    
    @State var disableSubmit: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            MeaningRow(meanings: task.getWord().chinese_meanings, type: task.getWord().chinese_type)
            
            // Buttons
            HStack {
                WideButton(label: "提交", action: pressSubmit, center: true).disabled(disableSubmit)
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
            }
            
            
            if settings.isHandwriting() {
                // Handwriting
                    Text(label)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                        .padding()
                        .background(base)
                        .border(isCorrect ? base : red)
                
                    // Writing pad
                    canvas.frame(width: 700, height: 150)

                    Text("在上方区域写出假名")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                    Text("Double tap切换橡皮擦")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
            } else {
                // Type
                
                TextField("在此输入假名", text: $label) {
                    self.pressSubmit()
                }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                    .padding()
                    .background(base)
                .border(isCorrect ? base : red)

            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        disableSubmit = true
        let expectedLabel = task.getWord().label
        
        // Handwriting
        if settings.isHandwriting() {
            let writtenLabel = canvas.getText()
            label = writtenLabel
        }
        
        if (expectedLabel == label) {
            task.setCorrect()
            currentPhase = LEARN_PHASE
        } else {
            print("wrong")
            isCorrect = false
        }
        
        disableSubmit = false
    }
    
    func pressUnableToSpell() {
        task.setWrong()
        currentPhase = LEARN_PHASE
    }
}


