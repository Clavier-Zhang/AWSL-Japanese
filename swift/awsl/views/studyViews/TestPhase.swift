//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


struct TestPhase: View {
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    var canvas : WritingPad = WritingPad()
    
    @State var label: String = ""
    
    @State var disableSubmit: Bool = false
    
    @State var images: [UIImage] = [UIImage]()
    
    @State var image: UIImage = UIImage()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            MeaningRow(meanings: task.getWord().chinese_meanings, type: task.getWord().chinese_type)
            
            // Buttons
            HStack {
                WideButton(label: "提交", action: pressSubmit, center: true).disabled(disableSubmit)
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
            }
            
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                }
            }
            
            Image(uiImage: image)
            
//            ForEach(_,id,self.images) {
//                Image(uiImage: self.images[id])
//            }
           
            // Recognized text
            Text(label)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .padding()
                .background(base)
        
            // Writing pad
            canvas.frame(width: 700, height: 150)

            // Instructions
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        disableSubmit = true
        
        print("press submit")
        label = canvas.getText()
        print("label:", label)

        // Check the answer
//        task.setCorrect()
//        currentPhase = LEARN_PHASE
        disableSubmit = false
    }
    
    func pressUnableToSpell() {
        task.setWrong()
        currentPhase = LEARN_PHASE
    }
}


