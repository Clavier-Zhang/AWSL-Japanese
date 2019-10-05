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
    }
    
    private func start() {
        print("start")
        var user = User(email: "sssssss", password: "aaaaaa")
//        Local.save(key: "123", obj: user.toData())
        
        let res = try? JSONDecoder().decode(LoginResponse.self, from: Local.get(key: "123")!)
        print(Local.get(key: "123"))
    }
}
