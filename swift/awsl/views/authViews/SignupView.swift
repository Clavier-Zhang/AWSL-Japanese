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
                        PasswordField(bind: $repassword, isRepassword: true)
                        Divider()
                    }
                    
                    Spacer().frame(height: 10)
                    
                    VStack(spacing: 20) {
                        RedButton(text: "Submit".localized(), isLoading: $isLoading, action: signup)
                        RedButton(text: "Back".localized(), action: back)
                    }
                    
                    NavigationLink(destination: HomeView(), isActive: $toHome) {
                        EmptyView()
                    }
                    
                }
                .frame(width: 300, height: fullHeight)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200)
            .background(studyCardBase)
            .foregroundColor(fontBase)
            .offset(y:-100)
        }
        .modifier(NavigationViewHiddenStyle())
    }
    
    func back() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
    
    func signup() {
        
        if (password.count < 6) {
            notification("Fail to sign up: password should contain at least 6 characters".localized(), .danger)
            return
        }
        
        if (password != repassword) {
            notification("Fail to sign up: passwords do not match".localized(), .danger)
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
        
        func handleFail() {
            self.message = "Can not connect to server".localized()
            wait.leave()
        }

        Remote.sendPostRequest(path: "/user/create", data: data, handleSuccess: handleSuccess, handleFail: handleFail)
        
        wait.notify(queue: .main) {
            if (self.status) {
                notification("Success to sign up".localized(), .success)
                self.toHome = true
            } else {
                notification("Fail to sign up: "+self.message, .danger)
            }
            self.isLoading = false
        }
    }
    
}

