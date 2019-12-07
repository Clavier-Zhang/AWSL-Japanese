//
//  ReviewList.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ReviewList: View {
    
    @State var reviewWords: [Word]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("复习:").frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            ForEach(0..<reviewWords.count) { idx in
                HStack {
                    
                    Text(self.reviewWords[idx].text+"【"+self.reviewWords[idx].label+"】")
                        .frame(width: 200, alignment: .leading)
                    
                    Text(self.reviewWords[idx].chinese_meanings[0])
                        .frame(width: 250, alignment: .leading)
                    
                    Text(String(self.reviewWords[idx].reviewCount!))
                        .frame(width: 50, alignment: .center)

                
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            }
        }
        
    }
    

}

