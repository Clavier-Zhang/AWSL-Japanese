//
//  FinishStudyView.swift
//  awsl
//
//  Created by clavier on 2019-10-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import NotificationBannerSwift

struct SubmissionPhase: View {
    
    // Data
    @Binding var task: Task
    
    // Navigation
    @State var back: () -> Void
    @State var toHomeView: Bool = false
    
    // Request
    @State var isLoading = false
    @State var status = false
    @State var message = "“"

    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 50) {
                    
                    Spacer().frame(height: 10)
                    
                    HStack {
                        CountLabel(label: "Time".localized(), title: task.getTime())
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    ReviewList(reviewWords: task.getTopReviewWords(count: 5))
                        .padding()
                        .background(base)
                        
                        
                        
                    RedButton(text: "Submit".localized(), isLoading: $isLoading, action: pressSubmit)
                    
                    
                }
                .frame(width: AwslStyle.SUBMISSION_WIDTH, alignment: .top)
            }
            .frame(width: WIDTH, height: HEIGHT-HEADER_HEIGHT, alignment: .top)
            .background(studyCardBase)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200, alignment: .bottom)
        .background(base)
        .foregroundColor(fontBase)
        .offset(y:-200)
    }
    
    func pressSubmit() {
        
        isLoading = true
        let wait = DispatchGroup()
        wait.enter()
        
        let report = Report(task: task)
        let data = objToData(obj: report)

        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                self.status = res.status
                self.message = res.message
            }
            wait.leave()
        }
        
        func handleFail() {
            self.message = "Can not connect to server".localized()
            wait.leave()
        }
        
        Remote.sendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
            
        wait.notify(queue: .main) {
            if (self.status) {
                notification("Success to submit".localized(), .success)
                self.task.isSubmitted = true
                self.task.save()
                self.back()
            } else {
                notification("Fail to submit: ".localized()+self.message, .danger)
            }
            self.isLoading = false
        }
        
    }
    
    
    
}

