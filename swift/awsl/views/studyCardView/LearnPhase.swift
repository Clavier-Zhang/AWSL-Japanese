//
//  LearnPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-25.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct LearnPhase: View {
    
    @Binding var currentPhase : String
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Spacer().frame(width: 20)
                Text("上手     [あか] [aka]")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                Divider()
                Spacer().frame(width: 20)
                Image(systemName: "speaker")
                    .frame(width: 30)
                Spacer().frame(width: 20)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
            
            HStack {
                Spacer().frame(width: 20)
                Text("【名词】\n1.红，红色。\n2.（酱，狗毛等的）茶色。\n 3.赤色分子。")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
            
            
            
               Spacer().frame(height: 500)
            
    
               HStack {
                   Spacer().frame(width: 20)
                   Text("不认识")
                   .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
               }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
               .background(base)
               
        
               

        }
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}
