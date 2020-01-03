//
//  UserProfile.swift
//  awsl
//
//  Created by clavier on 2019-10-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct UserProfile: View {
    
    @State var toLoginView = false
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            if !UIDevice.isPad {
                Spacer().frame(height: 40)
            }
            
            HStack (spacing: 10) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Capsule())
                Text(user.email)
                
                
                if UIDevice.isPad {
                    Button(action: logout) {
                        HStack {
                            Text("退出")
                        }
                    }
                    .buttonStyle(LogoutButtonStyle())
                }
                
                
                NavigationLink(destination: LoginView(), isActive: $toLoginView) {
                    EmptyView()
                }
                
            }.frame(minWidth: 0, maxWidth: .infinity)
            
            if !UIDevice.isPad {
                Button(action: logout) {
                    HStack {
                        Text("退出")
                    }
                }
                .buttonStyle(LogoutButtonStyle())
            }
        }
        
    }
    
    func logout() {
        User.delete()
        Task.delete()
        Settings.delete()
        toLoginView = true
    }
}

struct LogoutButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 90, height: 30)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(10)
    }

}
