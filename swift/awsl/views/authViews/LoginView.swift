//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//


import SwiftUI
import Combine



struct LoginView: View {
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var toSignUp: Bool = false
    
    @State var toHome: Bool = false
    
    @State var message: String = ""

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    EmailField(bind: $email)

                    Divider()
                    
                    Spacer().frame(height: 20)
                    
                    PasswordField(bind: $password)
                    
                    Divider()
                    
                    ErrorMessage(message)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Sign In
                        RedButton(text: "登录", action: login)
                        // Sign Up
                        NavigationLink(destination: SignUpView()) {
                            Text("注册")
                        }.buttonStyle(LoginButtonStyle())
                    }
    
                    // Navigation Links
                    NavigationLink(destination: HomeView(), isActive: $toHome) {
                        EmptyView()
                    }
                    
                    Spacer().frame(height: 200)

                }.frame(width: 300, height: fullHeight)
            }
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
        }
            .modifier(NavigationViewHiddenStyle())
    }
    
    
    
    private func login() -> Void {
        
        let user = User(email: self.email, password: self.password, token: "")

        let data = objToData(obj: user)
        
        func handleSuccess(data: Data) -> Void {
            
            let res : Response? = dataToObj(data: data)
            
            if res == nil {
                self.message = "Decode fails"
            }
            if let res = res {
                print(res)
                if (res.status) {
                    Local.save(key: "user", obj: res.user)
                    self.toHome = true
                } else {
                    self.message = res.message
                }
            }
        }
        
        Remote.sendPostRequest(path: "/user/login", data: data, handleSuccess: handleSuccess)
        
        
    }
}
