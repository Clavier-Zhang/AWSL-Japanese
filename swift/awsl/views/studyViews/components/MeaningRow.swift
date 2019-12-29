//
//  MeaningRow.swift
//  awsl
//
//  Created by clavier on 2019-10-11.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct MeaningRow: View {
    
    @State var meanings: [String]
    
    @State var type: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            
            ScrollView {
                
                Spacer().frame(height: 10)
                
                // Type
                Text(type)
                    .font(large).bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 20)
                
                // Meanings
                ForEach(0..<self.meanings.count) { idx in
                    Text(String(idx+1) + ". " + self.meanings[idx])
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 10)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(width: 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
        .background(base)
    }
}

