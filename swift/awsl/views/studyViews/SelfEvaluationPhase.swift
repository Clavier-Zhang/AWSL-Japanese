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
        VStack(spacing: 10) {
            
            WordRow(task: task, withFurigara: false)
            
            if (task.getStatus() == NEW) {
                WideButton(label: "Easy".localized(), action: pressEasy)
            }
            
            VStack {
                WideButton(label: "Know".localized(), action: pressKnow)
                Spacer().frame(height: 10)
                WideButton(label: "Not Know".localized(), action: pressNotKnow)
                Spacer().frame(height: AwslStyle.SELF_EVALUATION_GAP)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            

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

