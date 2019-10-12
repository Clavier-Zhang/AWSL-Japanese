//
//  WideButton.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct WideButton: View {
    
    var label: String
    
    var action: () -> Void
    
    var center: Bool = false
    
    public init(label: String, action: @escaping () -> Void, center: Bool? = false) {
        self.label = label
        self.action = action
        if let center = center {
            self.center = center
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: center ? .center : .leading)
        }.buttonStyle(WideButtonStyle())
    }
}

struct WideButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            .cornerRadius(5)
            .background(configuration.isPressed ? base.opacity(0.5) : base)
            .foregroundColor(configuration.isPressed ? fontBase.opacity(0.85) : fontBase)
    }

}
