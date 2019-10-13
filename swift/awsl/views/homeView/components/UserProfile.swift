//
//  UserProfile.swift
//  awsl
//
//  Created by clavier on 2019-10-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct UserProfile: View {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack (spacing: 20) {
            Image("1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Capsule())
            
            VStack (alignment: .leading) {
                Text("Claveir")
                    .font(.largeTitle)
                    .bold()
                    .frame(height: 30)
                Spacer().frame(height: 30)
                Text(user.email)
            }
        }
    }
}

