//
//  RedButton.swift
//  awsl
//
//  Created by clavier on 2019-10-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct RedButton: View {
    
    var text: String
    
    var action: () -> Void
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
        }.buttonStyle(LoginButtonStyle())
    }
    
}


struct LoginButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 40)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(20)
    }

}
