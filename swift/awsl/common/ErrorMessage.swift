//
//  ErrorMessage.swift
//  awsl
//
//  Created by clavier on 2019-10-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ErrorMessage: View {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 10)
            Text(message).foregroundColor(red)
            Spacer().frame(height: 10)
        }.frame(height: 40)
    }
}
