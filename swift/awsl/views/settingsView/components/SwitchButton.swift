//
//  SwitchButton.swift
//  awsl
//
//  Created by clavier on 2020-01-04.
//  Copyright © 2020 clavier. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct SwitchButton: View {
    
    // Passed values
    @Binding var isX : Bool
    @Binding var settings : Settings
    @State var text1 : String
    @State var text2 : String
    
    // Optional
    @State var isDisabled : Bool = false
    
    // local
    @State var offset : CGFloat = 0
 
    
    var body: some View {
        HStack {
            ZStack (alignment: .leading) {
                
                Spacer()
                    .frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH, height: 40)
                    .background(red)
                    .offset(x: isX ? 0 : AwslStyle.SETTINGS_SWITCH_WIDTH)
                    .animation(.interactiveSpring())
                
                HStack(spacing: 0) {
                    Button(action: action1) {
                        Text(text1.localized()).frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH, height: 40)
                    }
                    .disabled(isDisabled)
                    
                    Button(action: action2) {
                        Text(text2.localized()).frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH, height: 40)
                    }
                    .disabled(isDisabled)
                }
                
            }
                
        }
        .background(base)
        .cornerRadius(15)
        
    }
    
    func action1() {
        self.isX = true
        self.settings.save()
        Localize.setCurrentLanguage(Settings.get().isCN ? "zh-Hans" : "en")
    }
    
    func action2() {
        self.isX = false
        self.settings.save()
        Localize.setCurrentLanguage(Settings.get().isCN ? "zh-Hans" : "en")
    }
}

struct SwitchButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
//            .frame(width: AwslStyle.SETTINGS_SWITCH_WIDTH, height: 40)
            .background(configuration.isPressed ? yellow.opacity(0.5) : yellow)
//            .cornerRadius(20)
//            .font(.system(size: 30))
    }

}
