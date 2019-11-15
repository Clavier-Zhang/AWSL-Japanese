//
//  HomeView.swift
//  awsl
//
//  Created by clavier on 2019-09-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    // View data
    @State var homeResponse: HomeResponse = HomeResponse()
    @State var user: User = Local.get(key: "user")!
    @State var task: Task = Local.getTask()
    
    // Navigation
    @State var toStudyCardView = false
    @State var toFinishStudyView = false
    @State var disableStart = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                
                HStack (spacing: 100) {
                    UserProfile(user: user)
                    CountLabel(label: "已完成", count: homeResponse.finishedWordCount)
                    CountLabel(label: "进行中", count: homeResponse.progressingWordCount)
                    CountLabel(label: "详细>>", icon: "chart.bar")
                }
                
                Divider()
                
                HStack(spacing: 100) {
                    CountLabel(label: "单词书", title: homeResponse.currentPlan)
                    CountLabel(label: "剩余", count: homeResponse.currentPlanLeftWordCount)
                    CountLabel(label: "每日计划", count: homeResponse.scheduledWordsCount)
                    CountLabel(label: "选择>>", icon: "book")
                }
                
                Divider()
               
                if (task.date == Date().toNum()) {
                    HStack(spacing: 100) {
                        CountLabel(label: "新单词", count: task.getNewCount())
                        CountLabel(label: "剩余单词", count: task.getRemainCount())
                        CountLabel(label: "总共", count: task.getTotalCount())
                    }
                } else {
                    HStack(spacing: 100) {
                        CountLabel(label: "新单词", title: "N/A")
                        CountLabel(label: "剩余单词", title: "N/A")
                        CountLabel(label: "总共", title: "N/A")
                    }
                }
                
                                           
                Spacer().frame(height: 50)
                
                
                
                RedButton(text: "开始", action: pressStart, isDisabled: disableStart)
                
                
                // Navigation Links
                NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                    EmptyView()
                }
                
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
                .onAppear(perform: homeAppear)
        }.modifier(NavigationViewHiddenStyle())
    }
    
    func pressStart() {
        print("print start")
        
        disableStart = true
        
        let today = Date().toNum()
        
        func handleSuccess(data: Data) -> Void {
            let res : TaskResponse? = dataToObj(data: data)
            if let res = res {
                if (res.status) {
                    let task = Task(words: res.words, date: today, newCount: res.newWordsCount)
                    task.save()
                    self.toStudyCardView = true

                } else {
                    print("Decode task fail")
                }
            }
            disableStart = false
        }
        
        // Already fetch today's task
        let task: Task? = Local.getTask()
        if let task = task, task.date == today {
            print("Today's task has been fetched")
            if (!task.submitted) {
                toStudyCardView = true
            } else {
                print("Task has been submitted")
            }

        // Otherwise
        } else {
            print("Fetch today's task")
            Remote.sendGetRequest(path: "/task/get/"+String(today), handleSuccess: handleSuccess, token: Local.getToken())
        }
    
    }
    
    func homeAppear() {
        
        task = Local.getTask()
        disableStart = false
        
        func handleSuccess(data: Data) -> Void {
            let res : HomeResponse? = dataToObj(data: data)
            if let res = res {
                NSLog("HomeView: Fetch home data")
                if (res.status) {
                    self.homeResponse = res
                } else {
                    NSLog("HomeView: Fetch home data fail")
                }
            }
        }
        
        Remote.sendGetRequest(path: "/user/home", handleSuccess: handleSuccess, token: Local.getToken())

    }

}

