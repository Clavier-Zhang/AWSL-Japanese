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
                    Spacer().frame(height: AwslStyle.SETTINGS_GAP)
                    VStack(spacing: 20) {
                        
                    //                      ******Future
                    //                    Picker("", selection: $settings.choosedLanguage) {
                    //                        ForEach(0 ..< settings.languageOptions.count) { index in
                    //                            Text(self.settings.languageOptions[index]).tag(index)
                    //                        }
                    //                    }.pickerStyle(SegmentedPickerStyle())
                    //                    Text("语言")
                        HStack {
                            Text("模式")
                            Picker("", selection: $settings.choosedMode) {
                                ForEach(0 ..< settings.modeOptions.count) { index in
                                    Text(self.settings.modeOptions[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .disabled(!UIDevice.isPad)
                        }
                        
                        if !UIDevice.isPad {
                            HStack {
                                Text("手机仅支持键盘模式")
                                    .font(.body)
                                    .foregroundColor(red)
                            }
                        }

                    }
                    .frame(width: AwslStyle.SETTINGS_WIDTH)
                }
                .frame(width: WIDTH, height: fullHeight-70, alignment: .top)
                .background(studyCardBase)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200, alignment: .bottom)
            .background(base)
            .foregroundColor(fontBase)
            .offset(y:-200)
        }
        .modifier(NavigationViewBackStyle(pressBack: pressBack))
    }
    
    func pressBack() {
        settings.save()
        presentationMode.wrappedValue.dismiss()
    }
}

