//
//  SignUpView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
    NavigationView {
        VStack {
            VStack {
                
                HStack {
                    Image(systemName: "person")
                        .frame(width: 30)
                    ZStack(alignment: .leading) {
                        if username.isEmpty {
                            Text("Username")
                                .opacity(0.4)
                        }
                        TextField("", text: $username)
                    }
                }
                
                Divider()
                
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
                
                HStack {
                    Image(systemName: "lock")
                        .frame(width: 30)
                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("Re-Password")
                                .opacity(0.4)
                        }
                        SecureField("", text: $password)
                    }
                }
                
                Divider()
                
                Spacer().frame(height: 20)
                
                NavigationLink (destination: HomeView()) {
                    Text("提交")
                }.buttonStyle(LoginButtonStyle())

                
                Spacer().frame(height: 200)

            }.frame(width: 300, height: fullHeight)
        }
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
            .navigationBarHidden(true)
    }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }
}

