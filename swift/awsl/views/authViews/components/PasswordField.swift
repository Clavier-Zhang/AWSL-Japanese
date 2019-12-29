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
    
    var placeHolder: String = "密码"

    public init(bind: Binding<String>, isRepassword: Bool = false) {
        self.password = bind
        if isRepassword {
            self.placeHolder = "再次输入密码"
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .frame(width: 30)
            ZStack(alignment: .leading) {
                if password.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(fontBase)
                        .opacity(0.4)
                }
                SecureField(placeHolder, text: password)
            }
        }
    }
    
}
