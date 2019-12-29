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
            Button(action: pressBack) {
                Spacer().frame(width: 20)
                Image(systemName: "house")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                Spacer().frame(width: 20)
            }
        }
        .frame(alignment: .leading)
    }
    

}


struct BaseViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200, alignment: .bottom)
            .background(base)
            .foregroundColor(fontBase)
            .offset(y:-200)
    }
}
