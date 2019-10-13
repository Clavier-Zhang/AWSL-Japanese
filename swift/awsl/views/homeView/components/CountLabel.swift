//
//  CountLabel.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct CountLabel: View {
    
    var count: Int = -1
    var label: String
    var icon: String = ""
    
    init(label: String, count: Int = -1, icon: String = "") {
        self.label = label
        self.count = count
        self.icon = icon
    }
    
    var body: some View {
        VStack {
            
            if count != -1 {
                Text(String(count))
                    .font(.largeTitle)
                    .bold()
                    .frame(height: 30)
            }
            
            if icon != "" {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            
            Spacer().frame(height: 30)
            
            Text(label)
            
        }
    }
}
