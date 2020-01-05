//
//  SettingsView.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct SettingsView: View {
    
    @State var settings = Settings.get()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var oldLanguage = Settings.get().isCN
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer().frame(height: AwslStyle.SETTINGS_GAP)
                    VStack(spacing: 20) {
                        
                        Text("Preview".localized())
                        if !settings.isHandwriting {
                            
                            VStack {
                                Text("Please enter ".localized()+(settings.isHiragana ? "Hiragana".localized() : "Romaji".localized()))
                                    .opacity(0.5)
                                    .frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH*2-20, height: 30, alignment: .leading)
                                    .padding()
                                    .background(base)
                                Image(systemName: "arrow.down")
                                Text(settings.isHiragana ? "ふぶき" : "hubuki")
                                    .opacity(0.5)
                                    .frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH*2-20, height: 30, alignment: .leading)
                                    .padding()
                                    .background(base)
                            }
                            .frame(height: 210)
                            
                            
                            SwitchButton(isX: $settings.isHiragana, settings: $settings, text1: "Hiragana", text2: "Romaji")
                            
                        } else {
                            VStack {
                                Image(settings.isGrid ? "grid_writing" : "non_grid_writing")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH*2-20, height: 120, alignment: .leading)
                            }
                            .frame(height: 210)
                            
                            
                            SwitchButton(isX: $settings.isGrid, settings: $settings, text1: "Grid", text2: "No Grid")
                        }
                        
                        
                        
                        SwitchButton(isX: $settings.isHandwriting, settings: $settings, text1: "Handwriting", text2: "Keyboard", isDisabled: !UIDevice.isPad)

                        if !UIDevice.isPad {
                            HStack {
                                Text("Only supports Keyboard Mode on iPhone".localized())
                                    .font(FONT_SMALL)
                                    .foregroundColor(red)
                            }
                        }
                        
                        SwitchButton(isX: $settings.isCN, settings: $settings, text1: "中文", text2: "English")
                        
                        HStack {
                            if oldLanguage != settings.isCN {
                                Text("Restart to change language".localized())
                                    .font(FONT_SMALL)
                                    .foregroundColor(red)
                            }
                        }
                        .frame(height: 30)
                        

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
        Localize.setCurrentLanguage(Settings.get().isCN ? "zh-Hans" : "en")
        presentationMode.wrappedValue.dismiss()
    }
    
    func test() {
        print("test")
    }
}

