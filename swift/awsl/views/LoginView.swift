//
//  LoginView.swift
//  awsl
//
//  Created by clavier on 2019-09-11.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct User: Codable {
    let email: String
    let password: String
    let token: String = ""
}

let user = User(email: "zyc1014551629@gmail.com", password: "zyc990610")




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
                        ZStack(alignment: .leading) {
                            if username.isEmpty {
                                Text("Username")
                                    .foregroundColor(fontBase)
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
                                    .foregroundColor(fontBase)
                                    .opacity(0.4)
                            }
                            SecureField("Password", text: $password)
                        }
                    }

                    Divider()

                    Spacer().frame(height: 20)

                    Button(action: {
                        
                        guard let uploadData = try? JSONEncoder().encode(user) else {
                            return
                        }
                        
                        
                        let url = URL(string: "http://192.168.31.158:8000/api/user/login")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
                            if let error = error {
                                print ("error: \(error)")
                                return
                            }
                            guard let response = response as? HTTPURLResponse,
                                (200...299).contains(response.statusCode) else {
                                print ("server error")
                                return
                            }
                            if let mimeType = response.mimeType,
                                mimeType == "application/json",
                                let data = data,
                                let dataString = String(data: data, encoding: .utf8) {
                                print ("got data: \(dataString)")
                            }
                        }
                        
                        task.resume()

                        
                        print(url)

      
                    }){
                        Text("test")
                    }

                    NavigationLink (destination: HomeView()) {
                        Text("Sign In")
                    }.buttonStyle(LoginButtonStyle())

                    Spacer().frame(height: 20)

                    NavigationLink (destination: SignUpView()) {
                        Text("Sign Up")
                    }.buttonStyle(LoginButtonStyle())

                    Spacer().frame(height: CGFloat(200))

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
            .navigationBarHidden(true)
    }
}
