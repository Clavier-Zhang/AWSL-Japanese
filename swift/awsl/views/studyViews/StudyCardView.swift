//
//  SwiftUIView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct StudyCardView: View {
    
    // View data
    @State var task: Task = Local.getTask()
    
    @State var currentPhase : String = Local.getTask().isEmpty() ? SUBMISSION_PHASE : SELF_EVALUATION_PHASE
    
    @State var timer: Timer?
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var toFinishStudyView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                VStack {

                    VStack {
                        
                        Spacer().frame(height: 30)
                        
                        ProgressBar(new: task.getNewNum(), finished: task.getFinishedNum(), review: task.getReviewNum())
                            .padding(.vertical)
                        
                        Spacer().frame(height: 30)
                    
                        if (currentPhase == SELF_EVALUATION_PHASE) {
                            SelfEvaluationPhase(currentPhase: $currentPhase, task: $task)
                            
                        } else if (currentPhase == TEST_PHASE) {
                            TestPhase(currentPhase: $currentPhase, task: $task)
                            
                        } else if (currentPhase == LEARN_PHASE) {
                            LearnPhase(currentPhase: $currentPhase, task: $task)
                        } else if (currentPhase == SUBMISSION_PHASE) {
                            SubmissionPhase(back: back)
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
                .onAppear(perform: onAppear)
                .onDisappear(perform: onDisappear)
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
    
    func onAppear() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { timer in
            if (self.currentPhase != SUBMISSION_PHASE) {
                self.task.studyTime += 5
            }
        })
    }
    
    func onDisappear() {
        self.timer?.invalidate()
    }
    
}

