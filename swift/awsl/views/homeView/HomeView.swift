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
    
    @State var toLoginView = false
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: AwslStyle.HOMEVIEW_ROW_GAP) {
                
                NavigationLink(destination: LoginView(), isActive: $toLoginView) {
                    EmptyView()
                }
                
                Spacer().frame(height: 20)
                
                UserProfile(user: user)
                
                if self.message == "Can not connect to server" {
                    Text("Can not connect to server".localized()).foregroundColor(red)
                }
                
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
        
        func handleFail(text: String) {
            self.message = "Can not connect to server".localized()
            if text == "403" {
                self.message = "Token expire"
            }
            wait.leave()
        }

        func handleExit(text: String) {
            print("handle exit")
            print(text)
        }
        
        Remote.sendGetRequest(path: "/user/home", handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail, handleExit: handleExit)

        wait.notify(queue: .main) {
            if (!self.status) {
                print(self.message)
                if self.message == "Token expire" {
                    self.logout()
                }
                // fix later
//                notification("Fail to fetch user data: ".localized()+self.message, .danger)
            }
        }

    }
    
    func logout() {
        User.delete()
        Task.delete()
        Settings.delete()
        toLoginView = true
    }

}

