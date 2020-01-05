//
//  TaskRow.swift
//  awsl
//
//  Created by clavier on 2019-12-22.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    
    @Binding var task: Task
    
    @State var toSettingsView = false
    
    @State var dummy = false
    
    var body: some View {
        VStack {
            HStack (spacing: AwslStyle.COUNT_LABEL_GAP) {
                if task.isValid() {
                    CountLabel(label: "New".localized(), count: task.getNewCount())
                    CountLabel(label: "Today's Remain".localized(), count: task.getRemainCount())
                    CountLabel(label: "Total".localized(), count: task.getTotalCount())
                } else {
                    CountLabel(label: "New".localized(), title: "N/A")
                    CountLabel(label: "Today's Remain".localized(), title: "N/A")
                    CountLabel(label: "Total".localized(), title: "N/A")
                }
                Button(action: pressSettings) {
                    CountLabel(label: "Settings>>".localized(), icon: "gear")
                }
            }
            NavigationLink(destination: SettingsView(), isActive: $toSettingsView) {
                EmptyView()
            }
        }
    }
    
    func pressSettings() {
        toSettingsView = true
    }
}
