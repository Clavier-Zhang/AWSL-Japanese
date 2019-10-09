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

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                
                HStack (spacing: 100) {
                    
                    HStack (spacing: 20) {
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Capsule())
                        
                        VStack (alignment: .leading) {
                            Text("Claveir")
                                .font(.largeTitle)
                                .bold()
                                .frame(height: 30)
                            Spacer().frame(height: 30)
                            Text("ID: 13962125149")
                        }
                    }
                    
                    CountLabel(label: "已完成", count: 59)
                    
                    CountLabel(label: "进行中", count: 59)
                    
                    VStack {
                        Image(systemName: "chart.bar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Spacer().frame(height: 30)
                        Text("详细>>")
                    }
                    
                }
                
                Divider()
                
                HStack(spacing: 100) {
                    
                    CountLabel(label: "单词书", count: 59)
                    
                    CountLabel(label: "剩余", count: 59)
                    
                    VStack {
                        Image(systemName: "book")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Spacer().frame(height: 30)
                        Text("选择>>")
                    }
                    
                }
                
                Divider()
               
                HStack(spacing: 100) {
                    
                    CountLabel(label: "新单词", count: 100)
                    
                    CountLabel(label: "计划单词", count: 300)
                    
                    CountLabel(label: "剩余单词", count: 189)
                    
                }
                                           
                Spacer().frame(height: 50)
                
                // Start Button
                Button(action: self.pressStart) {
                    Text("开始").bold()
                }.buttonStyle(LoginButtonStyle())
                
                // Navigation Links
                NavigationLink(destination: StudyCardView(), isActive: $toStudyCardView) {
                    EmptyView()
                }
                
                Spacer().frame(height: 100)
                
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
            
            
            
            
        }
            .modifier(NavigationViewHiddenStyle())
            .onAppear(perform: self.homeAppear)
    }
    
    func pressStart() {
        func handleSuccess(data: Data) -> Void {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                print("start success")
                print(res)
                if (res.status) {
                    Local.save(key: "tasks", obj: res.words)
                    self.toStudyCardView = true
                    
                } else {
                    print("Status false")
                }
            }
        }
        Remote.fetchTask(handleSuccess: handleSuccess)
        
    }
    
    func homeAppear() {
        
        func handleSuccess(data: Data) -> Void {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                print("success fetch home data")
                if (res.status) {
                    self.loading = false
                    Local.save(key: "task", obj: res.words)
                } else {
                    print("Status false")
                }
            }
        }
        
        Remote.fetchHomeData(handleSuccess: handleSuccess)
    }
    
    
    


}
