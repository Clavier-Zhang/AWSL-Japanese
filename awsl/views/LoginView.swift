//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct LoginButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 40)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(20)
    }

}

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

                }.frame(width: 300, height: fullHeigth)
            }.frame(width: fullWidth, height: fullHeigth).background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
