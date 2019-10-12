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
    
    var body: some View {
        VStack {
            Spacer().frame(width: 20)

            ForEach(0..<self.meanings.count) { idx in
                Text(self.meanings[idx])
            }
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 120)
            .background(base)
    }
}

