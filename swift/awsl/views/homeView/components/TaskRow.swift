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
    
    var body: some View {
        VStack {
            HStack (spacing: AwslStyle.COUNT_LABEL_GAP) {
                if task.isValid() {
                    CountLabel(label: "新单词", count: task.getNewCount())
                    CountLabel(label: "剩余单词", count: task.getRemainCount())
                    CountLabel(label: "总共", count: task.getTotalCount())
                } else {
                    CountLabel(label: "新单词", title: "N/A")
                    CountLabel(label: "剩余单词", title: "N/A")
                    CountLabel(label: "总共", title: "N/A")
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
