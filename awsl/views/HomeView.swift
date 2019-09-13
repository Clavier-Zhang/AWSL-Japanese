//
//  HomeView.swift
//  awsl
//
//  Created by clavier on 2019-09-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                   
                    
                    Divider()
                    
                    Spacer().frame(height: 20)
                    
                    NavigationLink (destination: SignUpView()) {
                        Text("Sign In")
                    }.buttonStyle(LoginButtonStyle())

                    Spacer().frame(height: 20)
                    
                    NavigationLink (destination: SignUpView()) {
                        Text("Sign Up")
                    }.buttonStyle(LoginButtonStyle())
                    
                    Spacer().frame(height: 200)

                    }.frame(width: 300, height: fullHeigth).navigationBarBackButtonHidden(true)
            }.frame(width: fullWidth, height: fullHeigth).background(Color.init(red: 30/255, green: 30/255, blue: 30/255))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
