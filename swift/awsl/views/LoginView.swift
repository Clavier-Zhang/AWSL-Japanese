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
    
    @State var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    // Email Input
                    HStack {
                        Image(systemName: "person")
                            .frame(width: 30)
                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("Email")
                                    .foregroundColor(fontBase)
                                    .opacity(0.4)
                            }
                            // Avoid auto-capitalization
                            TextField("", text: $email)
                                .autocapitalization(UITextAutocapitalizationType.none)
                        }
                    }

                    Divider()
                    
                    // Password Input
                    HStack {
                        Image(systemName: "lock")
                            .frame(width: 30)
                        ZStack(alignment: .leading) {
                            if password.isEmpty {
                                Text("Password")
                                    .foregroundColor(fontBase)
                                    .opacity(0.4)
                            }
                            SecureField("Password", text: $password)
                        }
                    }
                    
                    Divider()
                    
                    // Error message
                    Text(errorMessage).foregroundColor(red)
                    Spacer().frame(height: 20)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Sign In
                        Button(action: login){
                            Text("登录")
                        }.buttonStyle(LoginButtonStyle())
                        // Sign Up
                        NavigationLink(destination: SignUpView()) {
                            Text("注册")
                        }.buttonStyle(LoginButtonStyle())
                    }
                    
                    // Navigation Links
                    NavigationLink(destination: HomeView(), isActive: $toHome) {
                        EmptyView()
                    }
                    
                    Spacer().frame(height: CGFloat(200))

                }.frame(width: 300, height: fullHeight)
            }
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
                .navigationBarHidden(true)
        }
            .modifier(NavigationViewHiddenStyle())
    }
    
    
    
    private func login() -> Void {
        
        let user = User(email: self.email, password: self.password)

        let data = user.toData()
        
        func handleSuccess(data: Data) -> Void {
            
            let res : LoginResponse? = dataToObj(data: data)
            
            if res == nil {
                self.errorMessage = "Decode fails"
            }
            if let res = res {
                print(res)
                if (res.status == true) {
                    self.toHome = true
                } else {
                    self.errorMessage = res.message
                }
            }
        }
        
        func handleError() -> Void {
            self.errorMessage = "Unknown error"
        }
        
        SendPostRequest(path: "/user/login", data: data, handleSuccess: handleSuccess, handleError: handleError)
        
        
    }
}


struct LoginResponse : Decodable {
    
    var status: Bool
    
    var message: String
    
    var user: User?
    
}
