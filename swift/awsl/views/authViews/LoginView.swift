//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//


import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var toSignUp: Bool = false
    
    @State var toHome: Bool = false
    
    
    
    // Request
    @State var isLoading = false
    @State var status = false
    @State var message = ""

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
                    
                    Spacer().frame(height: 10)
                    
                    VStack(spacing: 20) {
                        RedButton(text: "登录", isLoading: $isLoading, action: login)
                        NavigationLink(destination: SignUpView()) {
                            Text("注册")
                        }.buttonStyle(LoginButtonStyle())
                    }
    
                    NavigationLink(destination: HomeView(), isActive: $toHome) {
                        EmptyView()
                    }
                    
                    Spacer().frame(height: 200)

                }
                .frame(width: 300)
            }
            .modifier(BaseViewStyle())
        }
        .modifier(NavigationViewHiddenStyle())
    }

    
    func login() -> Void {
        
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
                    print(res)
                }
            }
            wait.leave()
        }
        
        Remote.sendPostRequest(path: "/user/login", data: data, handleSuccess: handleSuccess)
        
        wait.notify(queue: .main) {
            if (self.status) {
                notification("登陆成功", .success)
                self.toHome = true
            } else {
                notification("登录失败: "+self.message, .danger)
            }
            self.isLoading = false
        }
        
    }

}


