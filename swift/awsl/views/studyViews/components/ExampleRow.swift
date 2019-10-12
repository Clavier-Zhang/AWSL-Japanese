//
//  ExampleRow.swift
//  awsl
//
//  Created by clavier on 2019-10-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ExampleRow: View {
    
    @State var examples: [Example]
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            
            Text("例句")
                .font(large).bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 20)
            
            
            ForEach(0..<min(self.examples.count, 5)) { idx in
                
                HStack {
                    // Japanese
                    Text("#    " + self.examples[idx].japanese)
                        .font(large)
                    // Translation
                    Text(self.examples[idx].translation)
                        .opacity(0.8)
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 20)
            }
        }
        .padding(.horizontal)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
            .background(base)
    }
    
}

