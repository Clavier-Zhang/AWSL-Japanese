//
//  BookListView.swift
//  awsl
//
//  Created by clavier on 2019-12-07.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import NotificationBannerSwift

struct PlanListView: View {
    
    // Data
    @State var data : PlanListResponse
    
    // Navigation
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State var status : Bool = false
    @State var isLoadingSave = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack (spacing: 10) {
                    
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
                    
                    RedButton(text: "保存", isLoading: $isLoadingSave, action: pressSave)
                    
                }
                .frame(width: 400, height: fullHeight)
            }
            .modifier(BaseViewStyle())
        }
        .modifier(NavigationViewBackStyle(pressBack: pressBack))
    }
    
    func pressBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func pressSave() {
        isLoadingSave = true
        let plan = data.planOptions[data.currentPlanOption].name
        let num = data.numOptions[data.currentNumOption]
        
        struct Body : Codable {
            let plan: String
            let num: Int
        }
        
        let body = Body(plan: plan, num: num)
        let data = objToData(obj: body)
        
        let wait = DispatchGroup()

        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                NSLog("PlanListView: Update plan and schedul")
                self.status = res.status
                if (res.status) {
                    
                } else {
                    print("PlanListView: Server return fail")
                }
            }
            isLoadingSave = false
            wait.leave()
        }
        
        wait.enter()
        
        Remote.sendPostRequest(path: "/session/update", data: data, handleSuccess: handleSuccess, token: Local.getToken())
            
        wait.notify(queue: .main) {
            if (self.status) {
                let banner = StatusBarNotificationBanner(title: "更新设置成功", style: .success)
                banner.show()
            } else {
                let banner = StatusBarNotificationBanner(title: "更新设置成功失败", style: .danger)
                banner.show()
            }
        }

    }
    
    
}



