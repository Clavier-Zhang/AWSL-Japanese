//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//


import SwiftUI
import NotificationBannerSwift


struct LoginView: View {
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var toSignUp: Bool = false
    
    @State var toHome: Bool = false
    
    @State var message: String = ""
    
    @State var isLoading = false

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    
                    EmailField(bind: $email)

                    Divider()
                    
                    Spacer().frame(height: 20)
                    
                    PasswordField(bind: $password)
                    
                    Divider()
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Sign In
                        RedButton(text: "登录", isLoading: $isLoading, action: login)
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

                }
                .frame(width: 300, height: fullHeight)
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
//                notification("未知错误", .danger)
            }
            
            if let res = res {
                if (res.status) {
//                    notification("登陆成功", .success)
                    user.save()
                    self.toHome = true
                } else {
                    

                }
            }
        }
        
        Remote.sendPostRequest(path: "/user/login", data: data, handleSuccess: handleSuccess)
        
        
    }
//
//    func notification(_ message: String, _ type: BannerStyle) {
//        let banner = StatusBarNotificationBanner(title: message, style: type)
//        banner.show()
//    }

}
