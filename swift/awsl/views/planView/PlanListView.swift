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
    
    
    @State var status = false
    @State var message = ""
    @State var isLoadingSave = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    Spacer().frame(height: AwslStyle.PLAN_GAP)
                    VStack(spacing: 0) {
                        
                        HStack {
                            Text("Plan".localized())
                                .frame(width: 85)
                                .offset(x: 80)
                            Picker(selection: $data.currentPlanOption, label: Text("")) {
                                ForEach(0..<self.data.planOptions.count) {
                                    Text(String(self.data.planOptions[$0].name)).tag($0)
                                }
                            }
                            .frame(minWidth: AwslStyle.PLAN_PICKER_WIDTH)
                            .pickerStyle(WheelPickerStyle())
                        }
                        .offset(x: -50)
                        
                        HStack {
                            Text("Scheduled".localized())
                                .frame(width: 85)
                                .offset(x: 80)
                            Picker(selection: $data.currentNumOption, label: Text("")) {
                                ForEach(0..<self.data.numOptions.count) {
                                    Text(String(self.data.numOptions[$0])).tag($0)
                                }
                            }
                            .frame(minWidth: AwslStyle.PLAN_PICKER_WIDTH)
                            .pickerStyle(WheelPickerStyle())
                        }
                        .offset(x: -50)
                            
//                        Spacer().frame(height: 0)
                        
                        RedButton(text: "Save".localized(), isLoading: $isLoadingSave, action: pressSave)
                        
                    }
                    .frame(width: AwslStyle.PLAN_WIDTH, alignment: .center)
                }
                .frame(width: fullWidth, height: fullHeight-70, alignment: .top)
                .background(studyCardBase)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200, alignment: .bottom)
            .background(base)
            .foregroundColor(fontBase)
            .offset(y:-200)
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
        wait.enter()

        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                NSLog("PlanListView: Update plan and schedul")
                self.status = res.status
                self.message = res.message
            }
            isLoadingSave = false
            wait.leave()
        }
        
        func handleFail() {
            self.message = "Can not connect to server".localized()
            wait.leave()
        }
        
        
        
        Remote.sendPostRequest(path: "/session/update", data: data, handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
            
        wait.notify(queue: .main) {
            self.isLoadingSave = false
            if (self.status) {
                notification("Success to update plan".localized(), .success)
            } else {
                notification("Fail to update plan: ".localized()+self.message, .danger)
            }
        }

    }
    
    
}



