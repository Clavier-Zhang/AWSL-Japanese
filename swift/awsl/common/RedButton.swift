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
    
    var isDisabled: Bool
    
    var action: () -> Void
    
    init(text: String, action: @escaping () -> Void, isDisabled: Bool = false) {
        self.text = text
        self.action = action
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
        }.disabled(isDisabled).buttonStyle(LoginButtonStyle())
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
