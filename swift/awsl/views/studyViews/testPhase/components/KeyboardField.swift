//
//  KeyboardField.swift
//  awsl
//
//  Created by clavier on 2020-01-03.
//  Copyright © 2020 clavier. All rights reserved.
//

import SwiftUI

struct KeyboardField: View {
    
    var isCorrect : Binding<Bool>
    
    var label : Binding<String>
    
    var pressSubmit : () -> Void
    
    init(label: Binding<String>, isCorrect: Binding<Bool>, pressSubmit: @escaping () -> Void) {
        self.isCorrect = isCorrect
        self.pressSubmit = pressSubmit
        self.label = label
    }
    
    var body: some View {
        TextField("在此输入假名", text: label) {
            self.pressSubmit()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
        .padding()
        .background(base)
        .border(isCorrect.wrappedValue ? base : red)
    }
    
}

