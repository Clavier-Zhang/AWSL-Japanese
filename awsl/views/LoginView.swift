//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    HStack {
                        Image(systemName: "person")
                            .frame(width: 30)
                        TextField("User Name", text: $username)
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "lock")
                            .frame(width: 30)
                        SecureField("Password", text: $password)
                    }
                    
                    Divider()
                    
                    Spacer().frame(height: 20)
                    
                    NavigationLink (destination: HomeView()) {
                        Text("Sign In")
                    }.buttonStyle(LoginButtonStyle())

                    Spacer().frame(height: 20)
                    
                    NavigationLink (destination: SignUpView()) {
                        Text("Sign Up")
                    }.buttonStyle(LoginButtonStyle())
                    
                    Spacer().frame(height: 200)

                }.frame(width: 300, height: fullHeight)
            }.frame(width: fullWidth, height: fullHeight+300).background(base).navigationBarHidden(true)
        }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
