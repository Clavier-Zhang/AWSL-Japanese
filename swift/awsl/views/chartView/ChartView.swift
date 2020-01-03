//
//  ChartView.swift
//  awsl
//
//  Created by clavier on 2019-12-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import SwiftUICharts
import Charts

struct ChartView: View {
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
            
//                LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart").padding().frame(width: 400, height: 400)
//                LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title", legend: "Legendary") // legend is optional
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .modifier(BaseViewStyle())
        }
        .modifier(NavigationViewBackStyle(pressBack: pressBack))
    }
    
    func pressBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

