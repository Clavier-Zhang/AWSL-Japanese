//
//  CountLabel.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct CountLabel: View {
    
    var count: Int
    var label: String
    
    init(_ label: String, _ count: Int) {
        self.label = label
        self.count = count
    }
    
    var body: some View {
        VStack {
            Text(String(count))
                .font(.largeTitle)
                .bold()
                .frame(height: 30)
            Spacer()
                .frame(height: 30)
            Text(label)
        }
    }
}
