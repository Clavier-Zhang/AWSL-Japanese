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
    
    // Message
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
                    
                    PasswordField(bind: $repassword)
                    
                    ErrorMessage(message)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        // Submit
                        RedButton(text: "提交", isLoading: false, action: signup)
                        // Back
                        RedButton(text: "返回", isLoading: false, action: back)
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
    
    
    
    func back() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
    
    
    func signup() -> Void {
        
        if (password != repassword) {
            message = "Re-Password does not match"
            return
        }
        
        let user = User(email: self.email, password: self.password, token: "")
        
        let data = objToData(obj: user)

        func handleSuccess(data: Data) -> Void {
            
            let res : Response? = dataToObj(data: data)
            
            if res == nil {
                self.message = "Decoder error"
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

        Remote.sendPostRequest(path: "/user/create", data: data, handleSuccess: handleSuccess)
        
    }
}

