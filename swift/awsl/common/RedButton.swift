//
//  RedButton.swift
//  awsl
//
//  Created by clavier on 2019-10-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct RedButton: View {
    
    @State var text: String
    
    @State var isLoading: Binding<Bool>
    
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                ActivityIndicator(isAnimating: isLoading, style: .medium)
                Text(text)
                Spacer().frame(width: 20)
            }
        }.disabled(isLoading.wrappedValue).buttonStyle(LoginButtonStyle())
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

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
