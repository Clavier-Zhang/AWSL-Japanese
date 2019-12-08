//
//  BookListView.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import Combine




struct PlanListView: View {
    
    // Data
    @State var data : PlanListResponse
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                VStack (spacing: 50) {
                    
                    HStack (spacing: 20) {
                        // Plan options
                        Picker(selection: $data.currentPlanOption, label: Text("单词书")) {
                            ForEach(0..<self.data.planOptions.count) {
                                Text(String(self.data.planOptions[$0].name)).tag($0)
                            }
                        }.pickerStyle(WheelPickerStyle())
                        // Num options
                        Picker(selection: $data.currentNumOption, label: Text("每日计划")) {
                            ForEach(0..<self.data.numOptions.count) {
                                Text(String(self.data.numOptions[$0])).tag($0)
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                    
                    RedButton(text: "保存", action: pressSave)
                    
                }.frame(width: 800, height: fullHeight)
            }.frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton)
        
    }
    

    
    var BackButton : some View {
        HStack {
            Spacer().frame(width: 20)
            Button(action: back) {
                Image(systemName: "house")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    
    func back() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func pressSave() {
        let plan = data.planOptions[data.currentPlanOption]
        let num = data.numOptions[data.currentNumOption]
        print(plan)
        print(num)
    }
    
}
