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
        ScrollView {
            
            Spacer().frame(height: 10)
            
            Text("例句")
                .font(AwslStyle.MIDDLE_FONT).bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
            Spacer().frame(height: 10)
                    
            ForEach(0..<self.examples.count) { idx in
                HStack {
                    // Japanese
                    Text("#    " + self.examples[idx].japanese).font(large)
                    // Translation
                    Text(self.examples[idx].translation).opacity(0.8)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 20)
            }
        }
        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: AwslStyle.EXAMPLE_HEIGHT, maxHeight: AwslStyle.EXAMPLE_HEIGHT, alignment: .leading)
        .background(base)

    }
    
}

