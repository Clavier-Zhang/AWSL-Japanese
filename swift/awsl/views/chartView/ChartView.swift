//
//  ChartView.swift
//  awsl
//
//  Created by clavier on 2019-12-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        .modifier(NavigationViewBackStyle(pressBack: pressBack))
    }
    
    func pressBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

