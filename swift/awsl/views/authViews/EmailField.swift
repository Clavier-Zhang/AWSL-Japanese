//
//  EmailField.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct EmailField: View {
    
    var email: Binding<String>

    public init(bind: Binding<String>) {
        self.email = bind
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .frame(width: 30)
            ZStack(alignment: .leading) {
                if email.wrappedValue.isEmpty {
                    Text("Email")
                        .opacity(0.4)
                }
                // Avoid auto-capitalization
                TextField("", text: email)
                    .autocapitalization(UITextAutocapitalizationType.none)
            }
        }
    }
    
}
