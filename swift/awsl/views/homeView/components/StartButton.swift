//
//  StartButton.swift
//  awsl
//
//  Created by clavier on 2019-12-22.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct StartButton: View {
    
    // Data
    @Binding var task: Task
    
    // Navigation
    @State var toStudyCardView = false
    
    // Request
    @State var isLoadingStart = false
    @State var message = ""
    @State var status = false
    
    var body: some View {
        VStack {
            if task.isValid() && task.isSubmitted {
                Text("已完成")
            } else {
                RedButton(text: "开始", isLoading: $isLoadingStart, action: pressStart)
            }
            NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                EmptyView()
            }
        }
    }
    
    func pressStart() {

        isLoadingStart = true
        
        let today = Date().toNum()

        // Today's task is valid, but not finished
        if task.isValid() {
            print("Today's task has been fetched")
            isLoadingStart = false
            toStudyCardView = true
            
        // Otherwise
        } else {
            
            let wait = DispatchGroup()
            wait.enter()
            
            func handleSuccess(data: Data) -> Void {
                let res : TaskResponse? = dataToObj(data: data)
                if let res = res {
                    self.status = res.status
                    self.message = res.message
                    if (res.status) {
                        self.task = Task(words: res.words, date: today, newCount: res.newWordsCount, isSubmitted: res.isSubmitted)
                        self.task.save()
                    }
                }
                wait.leave()
            }
            
            func handleFail() {
                self.message = "无法连接到服务器"
                wait.leave()
            }
            
            Remote.sendGetRequest(path: "/task/get/"+String(today), handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
            
            wait.notify(queue: .main) {
                if (self.status) {
                    if !self.task.isSubmitted {
                        self.toStudyCardView = true
                    }
                    notification("获取单词数据成功", .success)
                } else {
                    notification("获取单词数据失败: "+self.message, .danger)
                }
                self.isLoadingStart = false
            }
        }
    
    }
    

}
