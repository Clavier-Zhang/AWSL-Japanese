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
    
    @State var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            WordRow(task: task, withFurigara: true)
            
            MeaningRow(meanings: task.getWord().chinese_meanings, type: task.getWord().chinese_type)
            
            ExampleRow(examples: task.getWord().chinese_examples)
            

            Spacer().frame(height: AwslStyle.LEARN_GAP)
            
            RedButton(text: "下一个", isLoading: $isLoading, action: pressNext)

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
