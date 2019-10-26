//
//  AskPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit
import Foundation

struct SelfEvaluationPhase: View {
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    @State var player : AVAudioPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            
            WordRow(task: task, withFurigara: false)
            if (task.getStatus() == NEW) {
                WideButton(label: "太简单", action: pressEasy)
            }
            
            
            Spacer().frame(height: 400)
            
            WideButton(label: "认识", action: pressKnow)
            WideButton(label: "不认识", action: pressNotKnow)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }
    
    func pressNotKnow() {
        task.setWrong()
        currentPhase = LEARN_PHASE
    }
    
    func pressKnow() {
        currentPhase = TEST_PHASE
    }
    
    func pressEasy() {
        task.setEasy()
        currentPhase = LEARN_PHASE
    }
    
}

