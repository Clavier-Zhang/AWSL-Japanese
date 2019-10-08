//
//  HomeView.swift
//  awsl
//
//  Created by clavier on 2019-09-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct HomeView: View {

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
                    
                    CountLabel("已完成", 59)
                    
                    CountLabel("进行中", 59)
                    
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
                    
                    CountLabel("单词书", 59)
                    
                    CountLabel("剩余", 59)
                    
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
                    
                    CountLabel("新单词", 100)
                    
                    CountLabel("计划单词", 300)
                    
                    CountLabel("剩余单词", 189)
                    
                }
                                           
                Spacer().frame(height: 50)
                
                // Start Button
                Button(action: start) {
                    Text("开始").bold()
                }.buttonStyle(LoginButtonStyle())
                
                Spacer().frame(height: 100)
                
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
            
        }
            .modifier(NavigationViewHiddenStyle())
        .onAppear(perform: self.start)
    }
    
    private func start() {
        let user : User? = Local.get(key: "user")
        if user == nil {
            print("Defect: User not login")
            return
        }
//        print(user)
        let words : [Word]? = Local.get(key: "tasks")
//        fetchHomeData(user: user!)
        print(words)
        
    }
    
    private func fetchHomeData(user: User) -> Void {
        print("fetch homedata")
        
        func handleSuccess(data: Data) -> Void {
            print("success")

            let res : Response? = dataToObj(data: data)
            
            if let res = res {
                print(res)
                if (res.status) {
                    Local.save(key: "tasks", obj: res.words)

                } else {

                }
            }
        }
        
        SendGetRequest(path: "/user/home/"+user.email, handleSuccess: handleSuccess, token: user.token)
        
    }
    
    private func fetchTaskData(user: User) -> Void {
        print("fetch homedata")
        
        func handleSuccess(data: Data) -> Void {
            print("success")

            let res : Response? = dataToObj(data: data)
            
            if let res = res {
                print(res)
                if (res.status) {
                    Local.save(key: "tasks", obj: res.words)

                } else {

                }
            }
        }
        
        
        SendGetRequest(path: "/user/home/"+user.email, handleSuccess: handleSuccess, token: user.token)
        
        
    }
}
