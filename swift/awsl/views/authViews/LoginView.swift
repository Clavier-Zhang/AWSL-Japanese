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
    
    @State var toHome: Bool = false
    
    // Navigation
    @State var toSignUpView = false
    
    // Request
    @State var isLoading = false
    @State var dummyLoading = false
    @State var status = false
    @State var message = ""

    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 20) {
                    
                    Spacer().frame(height: 30)
                    
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
                        
                        RedButton(text: "Sign In".localized(), isLoading: $isLoading, action: login)
                        
                        RedButton(text: "Sign Up".localized(), isLoading: $dummyLoading, action: toSignUp)
                        
                    }
                    
                    HStack {
                        NavigationLink(destination: HomeView(), isActive: $toHome) {
                            EmptyView()
                        }
                        
                        NavigationLink(destination: SignUpView(), isActive: $toSignUpView) {
                            EmptyView()
                        }
                    }

                }
                .frame(width: 300)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200)
            .background(studyCardBase)
            .foregroundColor(fontBase)
            .offset(y:-100)
        }
        .modifier(NavigationViewHiddenStyle())
    }
    
    func toSignUp() {
        toSignUpView = true
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
                }
            }
            wait.leave()
        }
        
        func handleFail() {
            self.message = "Can not connect to server".localized()
            wait.leave()
        }
        
        Remote.sendPostRequest(path: "/user/login", data: data, handleSuccess: handleSuccess, handleFail: handleFail)
        
        wait.notify(queue: .main) {
            if (self.status) {
                notification("Success to sign in".localized(), .success)
                self.toHome = true
            } else {
                notification("Fail to sign in: ".localized()+self.message, .danger)
            }
            self.isLoading = false
        }
        
    }

}


