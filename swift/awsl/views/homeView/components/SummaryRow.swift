//
//  SummaryRow.swift
//  awsl
//
//  Created by clavier on 2019-12-22.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SummaryRow: View {
    
    @Binding var homeResponse: HomeResponse
    
    @State var toChartView = false
    
    var body: some View {
        VStack {
            HStack (spacing: 100) {
                if homeResponse.isValid() {
                    CountLabel(label: "已完成", count: homeResponse.finishedWordCount)
                    CountLabel(label: "进行中", count: homeResponse.progressingWordCount)
                } else {
                    CountLabel(label: "已完成", title: "N/A")
                    CountLabel(label: "进行中", title: "N/A")
                }
                
//              ****** Future
//              Button(action: pressChart) {
//                  CountLabel(label: "详细>>", icon: "chart.bar")
//              }
            }
            NavigationLink(destination: ChartView(), isActive: $toChartView) {
                EmptyView()
            }
        }
    }
    
    func pressChart() {
        toChartView = true
    }
}
