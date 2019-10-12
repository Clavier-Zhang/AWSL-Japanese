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
    
    @State var toFinishStudyView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            WordRow(task: task, withFurigara: true)
            
            MeaningRow(meanings: task.getWord().cn_meanings)
            
            // 例句
            VStack {
                Text("1. 3原色の一つ。人の血や燃える火の色。また，その系統の色。広義では紅色・桃色・だいだい色などをも含む。 红。红色。粉红色。红褐色。橘黄色。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                    .padding()
                    .background(base)
            }

            
            
            Spacer().frame(height: 300)
            
    
            Button(action: pressNext) {
                Text("下一个")
            }
                .frame(width: 300, height: 60, alignment: .center)
                .background(red)
            
            NavigationLink(destination: FinishStudyView(), isActive: $toFinishStudyView) {
                EmptyView()
            }

        }
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressNext() {
        
        task.next()
        if (!task.isEmpty()) {
            print("next")
            currentPhase = "SELF_EVALUATION"
        } else {
            toFinishStudyView = true
            print("all done")
        }
        
    }
}
