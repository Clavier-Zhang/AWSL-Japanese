//
//  SwiftUIView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


struct StudyCardView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentPhase : String = "SELF_EVALUATION"
    
    @State var task: Task = Local.getTask()

    var body: some View {
        NavigationView {
            VStack {
                VStack {

                    VStack {
                        
                        Spacer().frame(height: 30)
                        
                        ProgressBar(new: task.getNewNum(), finished: task.getFinishedNum(), review: task.getReviewNum())
                            .padding(.vertical)
                        
                        Spacer().frame(height: 30)
                    
                        if (self.currentPhase == "SELF_EVALUATION") {
                            SelfEvaluationPhase(currentPhase: $currentPhase, task: $task)
                            
                        } else if (self.currentPhase == "TEST") {
                            TestPhase(currentPhase: $currentPhase, task: $task)
                            
                        } else if (self.currentPhase == "LEARN") {
                            LearnPhase(currentPhase: $currentPhase, task: $task)
                        }
                        
                    }
                        .frame(width: 700, height: 1.05*fullHeight)

                }
                    .frame(width: fullWidth, height: 1.05*fullHeight)
                    .background(studyCardBase)
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
        }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)

    }
    
    
    
    var BackButton : some View {
        HStack {
            Spacer().frame(width: 20)
            Button(action: back) {
                Image(systemName: "house")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    
    func back() {
        presentationMode.wrappedValue.dismiss()
    }
}

