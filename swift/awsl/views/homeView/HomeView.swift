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
    @State var toSettingsView = false
    @State var toBookListView = false
    @State var isLoadingStart = false
    
    @State var planListResponse = PlanListResponse()
    
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
                    Button(action: pressBook) {
                        CountLabel(label: "选择>>", icon: "book")
                    }
                }
                
                Divider()
               
                if (task.date == Date().toNum()) {
                    HStack(spacing: 100) {
                        CountLabel(label: "新单词", count: task.getNewCount())
                        CountLabel(label: "剩余单词", count: task.getRemainCount())
                        CountLabel(label: "总共", count: task.getTotalCount())
                        Button(action: pressSettings) {
                            CountLabel(label: "设置>>", icon: "gear")
                        }
                        
                    }
                } else {
                    HStack(spacing: 100) {
                        CountLabel(label: "新单词", title: "N/A")
                        CountLabel(label: "剩余单词", title: "N/A")
                        CountLabel(label: "总共", title: "N/A")
                    }
                }
                
                                           
                Spacer().frame(height: 50)
                
                
                if task.isValid() && task.submitted {
                    Text("已完成")
                } else {
                    RedButton(text: "开始", isLoading: isLoadingStart, action: pressStart)
                }
                
                
                
                // Navigation Links
                NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                    EmptyView()
                }
                
                NavigationLink(destination: SettingsView(), isActive: $toSettingsView) {
                    EmptyView()
                }
                
                NavigationLink(destination: PlanListView(data: planListResponse), isActive: $toBookListView) {
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
        isLoadingStart = true
        
        let today = Date().toNum()
        
        func handleSuccess(data: Data) -> Void {
            let res : TaskResponse? = dataToObj(data: data)
            if let res = res {
                if (res.status) {
                    let task = Task(words: res.words, date: today, newCount: res.newWordsCount)
                    task.save()
                    self.toStudyCardView = true
                }
            }
            isLoadingStart = false
        }

        // Today's task is valid, but not finished
        if task.isValid() {
            print("Today's task has been fetched")
            isLoadingStart = false
            toStudyCardView = true
            
        // Otherwise
        } else {
            print("Fetch today's task")
            Remote.sendGetRequest(path: "/task/get/"+String(today), handleSuccess: handleSuccess, token: Local.getToken())
        }
    
    }
    
    func homeAppear() {
        // update home view
        task = Local.getTask()
        
        if task.isValid() && task.isEmpty() && !task.submitted {
            submitTask()
        }
        
        // Fetch homedata
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
    
    func submitTask() {
        print("submit task")
        let report = Report(task: task)
        let data = objToData(obj: report)
                    
        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                print("success submit task")
                if (res.status) {
                task.submitted = true
                task.save()
                } else {
                    print("Status false")
                }
            }
        }
        Remote.sendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: Local.getToken())
    }
    
    func pressSettings() {
        toSettingsView = true
    }
    
    func pressBook() {
        func handleSuccess(data: Data) -> Void {
            let res : PlanListResponse? = dataToObj(data: data)
            if let res = res {
                NSLog("BookListView: Fetch plan list data")
                if (res.status) {
                    planListResponse = res
                    toBookListView = true
                } else {
                    NSLog("BookListView: Fetch plan list data fail")
                }
            }
        }
        Remote.sendGetRequest(path: "/plan/list", handleSuccess: handleSuccess, token: Local.getToken())
    }

}

