//
//  SignUpView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//


import SwiftUI


struct SignUpView: View {
    
    // Input fields
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var toHome: Bool = false
    
    // Request
    @State var status = false
    @State var message: String = ""
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    
                    VStack {
                        EmailField(bind: $email)
                        Divider()
                    }
                    
                    VStack {
                        PasswordField(bind: $password)
                        Divider()
                    }
                    
                    VStack {
                        PasswordField(bind: $repassword)
                        Divider()
                    }
                    
                    Spacer().frame(height: 10)
                    
                    VStack(spacing: 20) {
                        RedButton(text: "提交", isLoading: $isLoading, action: signup)
                        RedButton(text: "返回", action: back)
                    }

                    Spacer().frame(height: 200)
                    
                }.frame(width: 300, height: fullHeight)
                
                NavigationLink(destination: HomeView(), isActive: $toHome) {
                    EmptyView()
                }
                
            }
            .modifier(BaseViewStyle())
        }
        .modifier(NavigationViewHiddenStyle())
    }
    
    func back() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
    
    func signup() {
        
        if (password != repassword) {
            notification("注册失败: 两次输入密码不一致", .danger)
            return
        }
        
        isLoading = true
        let wait = DispatchGroup()
        wait.enter()
        
        let user = User(email: self.email, password: self.password, token: "")
        let data = objToData(obj: user)

        func handleSuccess(data: Data) -> Void {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                status = res.status
                message = res.message
                if (res.status) {
                    res.user!.save()
                }
            }
            wait.leave()
        }

        Remote.sendPostRequest(path: "/user/create", data: data, handleSuccess: handleSuccess)
        
        wait.notify(queue: .main) {
            if (self.status) {
                notification("注册成功", .success)
                self.toHome = true
            } else {
                notification("注册失败: "+self.message, .danger)
            }
            self.isLoading = false
        }
    }
    
}

