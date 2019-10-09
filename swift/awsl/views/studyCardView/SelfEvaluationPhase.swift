//
//  AskPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SelfEvaluationPhase: View {
    
    @Binding var currentPhase : String
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer().frame(width: 20)
                Text("上手")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                Divider()
                Spacer().frame(width: 20)
                Image(systemName: "speaker")
                    .frame(width: 30)
                Spacer().frame(width: 20)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
            

            WideButton(label: "太简单", action: pressEasy)
            
            Spacer().frame(height: 400)
            
            WideButton(label: "认识", action: pressKnow)
            
            WideButton(label: "不认识", action: pressNotKnow)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }
    
    func pressNotKnow() {
        print("not know")
    }
    
    func pressKnow() {
        self.currentPhase = "TEST"
        print("know")
    }
    
    func pressEasy() {
        print("easy")
    }
    
}
