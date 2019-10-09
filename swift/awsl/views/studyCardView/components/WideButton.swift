//
//  WideButton.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct WideButton: View {
    
    var label: String
    
    var action: () -> Void
    
    public init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        HStack {
            Button(action: action) {
                Text(label)
            }.buttonStyle(WideButtonStyle())
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
        }
    
    }
}
