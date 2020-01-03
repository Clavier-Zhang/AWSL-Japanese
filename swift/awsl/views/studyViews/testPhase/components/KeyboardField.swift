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
    
    var body: some View {
        TextField("在此输入假名", text: $label) {
            self.pressSubmit()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
        .padding()
        .background(base)
        .border(isCorrect ? base : red)
    }
    
}

