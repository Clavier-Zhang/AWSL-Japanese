//
//  SettingsView.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }.frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton)
        
    }
    
    var BackButton : some View {
        HStack {
            Spacer().frame(width: 20)
            Button(action: back) {
                Image(systemName: "house")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    
    func back() {
        presentationMode.wrappedValue.dismiss()
    }
}

