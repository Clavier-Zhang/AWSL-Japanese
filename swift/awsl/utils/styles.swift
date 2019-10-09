//
//  styles.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct LoginButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 40)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(20)
    }

}

struct WideButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            .padding(.horizontal)
            .background(configuration.isPressed ? base.opacity(0.5) : base)
            .foregroundColor(configuration.isPressed ? fontBase.opacity(0.85) : fontBase)
            .cornerRadius(5)
    }

}


struct StartButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 60)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(20)
            .font(.system(size: 30))
    }

}



struct NavigationViewHiddenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text("Title"))
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
