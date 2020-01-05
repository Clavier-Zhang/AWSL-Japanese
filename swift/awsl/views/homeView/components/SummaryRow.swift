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
            HStack (spacing: AwslStyle.COUNT_LABEL_GAP) {
                if homeResponse.isValid() {
                    CountLabel(label: "Finished".localized(), count: homeResponse.finishedWordCount)
                    CountLabel(label: "Progressing".localized(), count: homeResponse.progressingWordCount)
                } else {
                    CountLabel(label: "Finished".localized(), title: "N/A")
                    CountLabel(label: "Progressing".localized(), title: "N/A")
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
