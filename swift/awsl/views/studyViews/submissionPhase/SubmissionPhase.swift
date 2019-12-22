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
    
    @Binding var task: Task
    
    @State var back: () -> Void
    
    @State var toHomeView: Bool = false
    
    @State var isLoading = false
    
    
    
    // Request
    @State var status = false

    var body: some View {
        HStack {
            VStack {
                
                CountLabel(label: "用 时", title: task.getTime())

                Spacer().frame(height: 80)
                
                ReviewList(reviewWords: task.getTopReviewWords(count: 5)).padding().background(studyCardBase)
                
                Spacer().frame(height: 50)
                    
                RedButton(text: "提交", isLoading: $isLoading, action: pressSubmit)
                
                Spacer().frame(height: 200)
                
            }.frame(width: 550, alignment: .top)
        }
        .modifier(BaseViewStyle())

    }
    
    func pressSubmit() {
        
        let wait = DispatchGroup()
        let report = Report(task: task)
        let data = objToData(obj: report)

        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                self.status = res.status
                print("success submit task")
                if (res.status) {
                    task.submitted = true
                    task.save()
                } else {
                    print("Status false")
                }
            }
            wait.leave()
        }
        
        wait.enter()
        
        Remote.sendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: Local.getToken())
            
        wait.notify(queue: .main) {
            if (self.status) {
                let banner = StatusBarNotificationBanner(title: "提交成功", style: .success)
                banner.show()
                self.back()
            } else {
                let banner = StatusBarNotificationBanner(title: "提交失败", style: .danger)
                banner.show()
            }
        }
        
                    
        
        
    }
    
    
    
}

