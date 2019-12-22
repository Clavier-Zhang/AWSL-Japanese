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

    @State var isLoadingStart = false
    @State var toChartView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                
                UserProfile(user: user)
                
                HStack (spacing: 100) {
                    CountLabel(label: "已完成", count: homeResponse.finishedWordCount)
                    CountLabel(label: "进行中", count: homeResponse.progressingWordCount)
//                    ****** Future
//                    Button(action: pressChart) {
//                        CountLabel(label: "详细>>", icon: "chart.bar")
//                    }
                }
                
                Divider()
                
                PlanRow(homeResponse: $homeResponse)
                
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
                        Button(action: pressSettings) {
                            CountLabel(label: "设置>>", icon: "gear")
                        }
                    }
                }
                
                                           
                Spacer().frame(height: 50)
                
                if task.isValid() && task.submitted {
                    Text("已完成")
                } else {
                    RedButton(text: "开始", isLoading: $isLoadingStart, action: pressStart)
                }
                
                
                
                // Navigation Links
                HStack {
                    
                    NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: SettingsView(), isActive: $toSettingsView) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: ChartView(), isActive: $toChartView) {
                        EmptyView()
                    }
                    
                }
                

                
            }
            .modifier(BaseViewStyle())
            .onAppear(perform: homeAppear)
        }
        .modifier(NavigationViewHiddenStyle())
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
    
    func pressSettings() {
        toSettingsView = true
    }
    
    func pressChart() {
        toChartView = true
    }

}

