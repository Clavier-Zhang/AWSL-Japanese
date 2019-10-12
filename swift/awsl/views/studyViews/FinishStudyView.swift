//
//  FinishStudyView.swift
//  awsl
//
//  Created by clavier on 2019-10-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct FinishStudyView: View {
    
    var body: some View {
        VStack {
            Text("finsihs")
            
            RedButton(text: "提交", action: pressSubmit)
        }.modifier(NavigationViewHiddenStyle())
    }
    
    func pressSubmit() {
        print("submit")
    }
    
}

