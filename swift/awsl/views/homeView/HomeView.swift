//
//  HomeView.swift
//  awsl
//
//  Created by clavier on 2019-09-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct HomeView: View {
    
    // Data
    @State var homeResponse: HomeResponse = HomeResponse()
    @State var user: User = Local.get(key: "user")!
    @State var task: Task = Local.getTask()
    
    // Request
    @State var message = ""
    @State var status = false
    
    @State var test = "Language"
    
    @State var test2 = "Language"
    
    var body: some View {
        NavigationView {
            VStack(spacing: AwslStyle.HOMEVIEW_ROW_GAP) {
                
                Spacer().frame(height: 20)
                
                UserProfile(user: user)
                
                SummaryRow(homeResponse: $homeResponse)
                
                Divider()
                
                PlanRow(homeResponse: $homeResponse)
                
                Divider()
                
                TaskRow(task: $task)
                
                StartButton(task: $task)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200)
            .background(studyCardBase)
            .foregroundColor(fontBase)
            .offset(y:-100)
            .onAppear(perform: homeAppear)
        }
        .modifier(NavigationViewHiddenStyle())
    }
    
    func homeAppear() {
        
        // update home view
        task = Local.getTask()
        
        print(task)
        
        let wait = DispatchGroup()
        wait.enter()

        // Fetch homedata
        func handleSuccess(data: Data) -> Void {
            let res : HomeResponse? = dataToObj(data: data)
            if let res = res {
                self.status = res.status
                self.message = res.message
                if (res.status) {
                    self.homeResponse = res
                }
            }
            wait.leave()
        }
        
        func handleFail() {
            self.message = "无法连接到服务器"
            wait.leave()
        }
        
        Remote.sendGetRequest(path: "/user/home", handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
        
        wait.notify(queue: .main) {
            if (!self.status) {
                notification("获取用户数据失败: "+self.message, .danger)
            }
        }

    }

}

