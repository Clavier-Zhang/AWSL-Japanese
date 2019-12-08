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
    
    @State var isLoadingSave = false
    
    let banner = StatusBarNotificationBanner(title: "11")
    
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
                    
                    RedButton(text: "保存", isLoading: isLoadingSave, action: pressSave)
                    
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
        isLoadingSave = true
        let plan = data.planOptions[data.currentPlanOption].name
        let num = data.numOptions[data.currentNumOption]
        
        struct Body : Codable {
            let plan: String
            let num: Int
        }
        
        let body = Body(plan: plan, num: num)
        let data = objToData(obj: body)
        
        
        banner.show()
        
        let myGroup = DispatchGroup()

        for i in 0 ..< 5 {
            myGroup.enter()
            
            func handleSuccess(data: Data) {
                let res : Response? = dataToObj(data: data)
                if let res = res {
                    print("success update plan list")
                    if (res.status) {
                        
                    } else {
                        print("Status false")
                    }
                }
                isLoadingSave = false
                myGroup.leave()
            }
            
            Remote.sendPostRequest(path: "/session/update", data: data, handleSuccess: handleSuccess, token: Local.getToken())
            
   
        }

        myGroup.notify(queue: .main) {
            print("Finished all requests.")
        }
        
        
            
        
        

    }
    
    
}



