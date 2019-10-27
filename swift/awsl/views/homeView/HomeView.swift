//
//  HomeView.swift
//  awsl
//
//  Created by clavier on 2019-09-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var loading: Bool = true
    
    @State var toStudyCardView = false
    
    @State var toFinishStudyView = false
    
    @State var homeResponse: HomeResponse = HomeResponse()
    
    @State var user: User = User(email: "", password: "", token: "")

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                
                HStack (spacing: 100) {
                    
                    UserProfile(user: user)
                    
                    CountLabel(label: "已完成", count: homeResponse.finishedNum)
                    
                    CountLabel(label: "进行中", count: homeResponse.progressingNum)
                    
                    CountLabel(label: "详细>>", icon: "chart.bar")
                    
                }
                
                Divider()
                
                HStack(spacing: 100) {
                    
                    CountLabel(label: "单词书", count: 33)
                    
                    CountLabel(label: "剩余", count: 59)
                    
                    CountLabel(label: "选择>>", icon: "book")
                    
                }
                
                Divider()
               
                HStack(spacing: 100) {
                    
                    CountLabel(label: "新单词", count: homeResponse.todayNewNum)
                    
                    CountLabel(label: "计划单词", count: homeResponse.todayScheduleNum)
                    
                    CountLabel(label: "剩余单词", count: 189)
                    
                }
                                           
                Spacer().frame(height: 50)
                
                // Start Button
                RedButton(text: "开始", action: pressStart)
                
                // Navigation Links
                NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                    EmptyView()
                }
                
            }
                .frame(width: fullWidth, height: fullHeight+200)
                .background(base)
                .foregroundColor(fontBase)
            
        }
            .modifier(NavigationViewHiddenStyle())
            .onAppear(perform: self.homeAppear)
    }
    
    func pressStart() {
        
        let today = Date().toNum()+1
        
        func handleSuccess(data: Data) -> Void {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                print(res)
                if (res.status) {
                    let task = Task(words: res.words!, date: today)
                    Local.save(key: "task", obj: task)
                    self.toStudyCardView = true

                } else {
                    print("Fetch task fail")
                }
            }
        }
        
        // Already fetch today's task
        let task: Task? = Local.get(key: "task")
        if let task = task, task.date == today {
            toStudyCardView = true
        // Otherwise
        } else {
            Remote.fetchTask(handleSuccess: handleSuccess, date: today)
        }
    
    }
    
    func homeAppear() {
        
        func handleSuccess(data: Data) -> Void {
            let res : HomeResponse? = dataToObj(data: data)
            if let res = res {
                print("success fetch home data")
                print(res)
                if (res.status) {
                    self.homeResponse = res
                    self.loading = false
                } else {
                    print("Status false")
                }
            }
        }
        
        Remote.fetchHomeData(handleSuccess: handleSuccess)
        
        let temp: User = Local.get(key: "user")!
        self.user = temp
    }
    
    
    
    
    


}
