//
//  PasswordField.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct PasswordField: View {
    
    var password: Binding<String>

    
    public init(bind: Binding<String>) {
        self.password = bind
    }
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .frame(width: 30)
            ZStack(alignment: .leading) {
                if password.wrappedValue.isEmpty {
                    Text("Password")
                        .foregroundColor(fontBase)
                        .opacity(0.4)
                }
                SecureField("Password", text: password)
            }
        }
    }
    
}
