//
//  LearnPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-25.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct LearnPhase: View {
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    var body: some View {
        VStack(spacing: 20) {
            
            WordRow(task: task, withFurigara: true)
            
            MeaningRow(meanings: task.getWord().cn_meanings, type: task.getWord().cn_type)
            
            ExampleRow(examples: task.getWord().cn_examples)

            Spacer().frame(height: 50)
            
            RedButton(text: "下一个", action: pressNext)

        }
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressNext() {
        task.next()
        if (!task.isEmpty()) {
            currentPhase = SELF_EVALUATION_PHASE
        } else {
            currentPhase = SUBMISSION_PHASE
        }
        
    }
}
