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
            
            HStack(alignment: .top) {
                Text("高频复习单词").bold().frame(width: 250, alignment: .leading)
                Text("释义").bold().frame(width: 250, alignment: .leading)
            }
            

            ForEach(0..<reviewWords.count) { idx in
                HStack(alignment: .top) {
                    
                    Text(self.reviewWords[idx].text+"【"+self.reviewWords[idx].label+"】")
                        .frame(width: 250, alignment: .topLeading)
                    
                    Text(self.reviewWords[idx].chinese_meanings[0])
                        .frame(width: 250, alignment: .topLeading)
                
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                
            }
        }
        
    }
    

}

