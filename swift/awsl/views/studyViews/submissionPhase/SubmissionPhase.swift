//
//  FinishStudyView.swift
//  awsl
//
//  Created by clavier on 2019-10-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SubmissionPhase: View {
    
    @State var task: Task = Local.getTask()
    
    @State var back: () -> Void
    
    @State var toHomeView: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                
                CountLabel(label: "用 时", title: task.getTime())

                Spacer().frame(height: 80)
                
                ReviewList(reviewWords: task.getTopReviewWords(count: 5)).padding().background(studyCardBase)
                
                Spacer().frame(height: 50)
                    
                RedButton(text: "返回", action: back)
                
                Spacer().frame(height: 200)
                
            }.frame(width: 550, alignment: .top)
        }
        
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)

    }
    
}

