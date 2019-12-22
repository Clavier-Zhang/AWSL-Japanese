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
        HStack {
            VStack(spacing: 50) {
                
                HStack {
                    CountLabel(label: "用 时", title: task.getTime())
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(studyCardBase)
                
                
                ReviewList(reviewWords: task.getTopReviewWords(count: 5))
                    .padding()
                    .background(studyCardBase)
                    
                RedButton(text: "提交", isLoading: $isLoading, action: pressSubmit)
                
                Spacer().frame(height: 300)
                
            }
            .frame(width: 550, alignment: .top)
        }
        .modifier(BaseViewStyle())
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
            self.message = "无法连接到服务器"
            wait.leave()
        }
        
        Remote.sendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
            
        wait.notify(queue: .main) {
            if (self.status) {
                notification("提交成功", .success)
                self.task.isSubmitted = true
                self.task.save()
                self.back()
            } else {
                notification("提交失败: "+self.message, .danger)
            }
            self.isLoading = false
        }
        
    }
    
    
    
}

