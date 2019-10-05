//
//  SignUpView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//


import SwiftUI


struct SignUpView: View {
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var repassword: String = ""
    
    @State var toHome: Bool = false
    
    @State var errorMessage: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    // Email input field
                    HStack {
                        Image(systemName: "person")
                            .frame(width: 30)
                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("email")
                                    .opacity(0.4)
                            }
                            // Avoid auto-capitalization
                            TextField("", text: $email)
                                .autocapitalization(UITextAutocapitalizationType.none)
                        }
                    }
                    Divider()
                    // Password input field
                    HStack {
                        Image(systemName: "lock")
                            .frame(width: 30)
                        ZStack(alignment: .leading) {
                            if password.isEmpty {
                                Text("Password")
                                    .opacity(0.4)
                            }
                            SecureField("", text: $password)
                        }
                    }
                    Divider()
                    // Repassword input field
                    HStack {
                        Image(systemName: "lock")
                            .frame(width: 30)
                        ZStack(alignment: .leading) {
                            if repassword.isEmpty {
                                Text("Re-Password")
                                    .opacity(0.4)
                            }
                            SecureField("", text: $repassword)
                        }
                    }
                    // Error message
                    Spacer().frame(height: 20)
                    Text(errorMessage).foregroundColor(red)
                    Spacer().frame(height: 20)
                    // Buttons
                    VStack(spacing: 20) {
                        // Sign In
                        Button(action: signup){
                            Text("提交")
                        }.buttonStyle(LoginButtonStyle())
                        // Sign Up
                        Button(action: back){
                            Text("返回")
                        }.buttonStyle(LoginButtonStyle())
                    }


                    Spacer().frame(height: 200)
                    
                    

                }.frame(width: 300, height: fullHeight)
                
                // Navigation Links
                NavigationLink(destination: HomeView(), isActive: $toHome) {
                    EmptyView()
                }
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
            
            
    
        }.modifier(NavigationViewHiddenStyle())
        
    }
    
    private func back() -> Void {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    private func signup() -> Void {
        
        if (password != repassword) {
            errorMessage = "Re-Password does not match"
            return
        }
        
        print(password == repassword)
        
        let user = User(email: self.email, password: self.password)

        guard let data = try? JSONEncoder().encode(user) else {
            return
        }

        func handleSuccess(data: Data) -> Void {
            let res = try? JSONDecoder().decode(LoginResponse.self, from: data)
            if let res = res {
                print(res)
                if (res.status) {
                    self.toHome = true
                } else {
                    self.errorMessage = res.message
                }
            }
        }

        func handleError() -> Void {
            self.errorMessage = "Unknown error"
        }

        SendPostRequest(path: "/user/create", data: data, handleSuccess: handleSuccess, handleError: handleError)
        
    }
}

