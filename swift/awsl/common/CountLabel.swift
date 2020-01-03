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
    var title: String = ""
    
    init(label: String, count: Int = -1, icon: String = "", title: String = "") {
        self.label = label
        self.count = count
        self.icon = icon
        self.title = title
    }
    
    var body: some View {
        VStack {
            
            if count != -1 {
                Text(String(count))
                    .font(AwslStyle.LARGE_FONT)
                    .bold()
                    .frame(height: 30)
            }
            
            if icon != "" {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            
            if title != "" {
                Text(title)
                    .font(AwslStyle.LARGE_FONT)
                    .bold()
                    .frame(height: AwslStyle.CountLabelSize)
            }
            
            Spacer().frame(height: AwslStyle.CountLabelSize)
            
            Text(label)
            
        }
    }
}
