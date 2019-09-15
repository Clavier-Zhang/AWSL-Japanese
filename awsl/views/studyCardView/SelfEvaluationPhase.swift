//
//  AskPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SelfEvaluationPhase: View {
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                Text("赤")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                Divider()
                Spacer().frame(width: 20)
                Image(systemName: "speaker")
                    .frame(width: 30)
                Spacer().frame(width: 20)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
            
            Spacer().frame(height: 30)
            
            HStack {
                Spacer().frame(width: 20)
                Text("太简单")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .leading)
                .background(base)
            
            Spacer().frame(height: 600)
            
            HStack {
                Spacer().frame(width: 20)
                Text("认识")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .leading)
                .background(base)
            
            HStack {
                Spacer().frame(width: 20)
                Text("不认识")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .bottomLeading)
                .background(base)
            

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }
}
