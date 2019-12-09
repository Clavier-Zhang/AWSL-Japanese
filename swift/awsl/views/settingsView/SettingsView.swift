//
//  SettingsView.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State var settings = Settings.get()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {

            
            VStack {
                VStack {
                    Picker("", selection: $settings.choosedLanguage) {
                        ForEach(0 ..< settings.languageOptions.count) { index in
                            Text(self.settings.languageOptions[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("语言")
                    
                    
                    
                }.frame(width: 800)
                
                
            }
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
        }.modifier(NavigationViewBackStyle(pressBack: pressBack))

    }
    
    func pressBack() {
        settings.save()
        presentationMode.wrappedValue.dismiss()
    }
}

