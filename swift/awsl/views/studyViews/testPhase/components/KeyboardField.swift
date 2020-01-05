//
//  KeyboardField.swift
//  awsl
//
//  Created by clavier on 2020-01-03.
//  Copyright © 2020 clavier. All rights reserved.
//

import SwiftUI

struct KeyboardField: View {
    
    @Binding var label : String
    
    @Binding var isCorrect : Bool
    
    @State var pressSubmit : () -> Void
    
    @State var settings : Settings
    
    var body: some View {
        TextField("Please enter ".localized()+(settings.isHiragana ? "Hiragana".localized() : "Romaji".localized()), text: $label) {
            self.pressSubmit()
        }
        .autocapitalization(UITextAutocapitalizationType.none)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
        .padding()
        .background(base)
        .border(isCorrect ? base : red)
    }
    
}

