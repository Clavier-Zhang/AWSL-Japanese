//
//  styles.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI



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

struct NavigationViewBackStyle: ViewModifier {
    
    var pressBack : () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)
    }
    
    var BackButton : some View {
        HStack {
            Spacer().frame(width: 20)
            Button(action: pressBack) {
                Image(systemName: "house")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    

}
