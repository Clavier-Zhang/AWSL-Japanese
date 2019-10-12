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
    
    var writingPad = WritingPadWrapper()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            MeaningRow(meanings: task.getWord().cn_meanings)
            
            // Buttons
            HStack {
                
                WideButton(label: "提交", action: pressSubmit, center: true)
                
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
                
            }
            
            writingPad
            
            
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        print("submit")
        writingPad.recognize()

        
    }
    
    func pressUnableToSpell() {
        print("spell fail")
        self.currentPhase = "LEARN"
    }
}


