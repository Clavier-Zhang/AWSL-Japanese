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
    
    @State var isLoading: Binding<Bool>?
    
    @State var action: () -> Void
    
    @State var defaultIsLoading = false
    
    var body: some View {
        Button(action: action) {
            HStack {
                ActivityIndicator(isAnimating: getLoadingStatus(), style: .medium)
                Text(text)
                Spacer().frame(width: 20)
            }
        }.disabled(getLoadingStatus().wrappedValue).buttonStyle(LoginButtonStyle())
    }
    
    func getLoadingStatus() -> Binding<Bool> {
        if let isLoading = isLoading {
            return isLoading
        }
        return $defaultIsLoading
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
