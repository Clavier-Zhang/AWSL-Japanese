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
    
    @State var hasKeyboard: Bool = false
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            
            if hasKeyboard {
                VStack {
                    
                    Spacer().frame(height: 10)
                    
                    if Settings.get().isCN {
                        Text(type)
                            .font(AwslStyle.MIDDLE_FONT)
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    // Meanings
                    ForEach(0..<min(3, self.meanings.count)) { idx in
                        Text(String(idx+1) + ". " + self.meanings[idx])
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 10)
                    }
                    
                }.frame(alignment: .leading)
                
            } else {
                ScrollView {
                    
                    Spacer().frame(height: 10)
                    
                    // Type
                    if Settings.get().isCN {
                        Text(type)
                            .font(AwslStyle.MIDDLE_FONT)
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    Spacer().frame(height: 10)
                    
                    // Meanings
                    ForEach(0..<self.meanings.count) { idx in
                        Text(String(idx+1) + ". " + self.meanings[idx])
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer().frame(height: 10)
                    }
                }
                .frame(alignment: .leading)
            }
            
            Spacer().frame(width: 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: AwslStyle.MEANING_HEIGHT, maxHeight: AwslStyle.MEANING_HEIGHT)
        .background(base)
    }
}

