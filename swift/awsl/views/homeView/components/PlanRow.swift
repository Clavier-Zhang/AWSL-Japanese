//
//  PlanRow.swift
//  awsl
//
//  Created by clavier on 2019-12-08.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct PlanRow: View {
    
    @Binding var homeResponse: HomeResponse
    
    @State var toBookListView = false
    
    @State var planListResponse = PlanListResponse()
    
    // Request
    @State var message = ""
    @State var status = false
    
    var body: some View {
        VStack {
            HStack(spacing: AwslStyle.COUNT_LABEL_GAP) {
                if homeResponse.isValid() {
                    CountLabel(label: "Plan".localized(), title: homeResponse.currentPlan)
                    CountLabel(label: "Remain".localized(), count: homeResponse.currentPlanLeftWordCount)
                    CountLabel(label: "Scheduled".localized(), count: homeResponse.scheduledWordsCount)
                } else {
                    CountLabel(label: "Plan".localized(), title: "N/A")
                    CountLabel(label: "Remain".localized(), title: "N/A")
                    CountLabel(label: "Scheduled".localized(), title: "N/A")
                }
                
                Button(action: pressBook) {
                    CountLabel(label: "Select>>".localized(), icon: "book")
                }
                
            }
            NavigationLink(destination: PlanListView(data: planListResponse), isActive: $toBookListView) {
                EmptyView().frame(width: 0).background(red)
            }
        }
    }
    
    func pressBook() {
        
        let wait = DispatchGroup()
        wait.enter()
        
        func handleSuccess(data: Data) -> Void {
            let res : PlanListResponse? = dataToObj(data: data)
            if let res = res {
                self.status = res.status
                NSLog("BookListView: Fetch plan list data")
                if (res.status) {
                    planListResponse = res
                    toBookListView = true
                } else {
                    NSLog("BookListView: Fetch plan list data fail")
                }
            }
            wait.leave()
        }
        
        func handleFail(text: String) {
            self.message = "Can not connect to server".localized()
            wait.leave()
        }
        
        func handleExit() {

        }
        
        Remote.sendGetRequest(path: "/plan/list", handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail, handleExit: handleExit)
        
        wait.notify(queue: .main) {
            if self.status {
//                notification("获取单词书列表成功", .success)
            } else {
                notification("Fail to fetch plan list: ".localized()+self.message, .danger)
            }
        }
    }
}

