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
                    CountLabel(label: "单词书", title: homeResponse.currentPlan)
                    CountLabel(label: "剩余", count: homeResponse.currentPlanLeftWordCount)
                    CountLabel(label: "每日计划", count: homeResponse.scheduledWordsCount)
                } else {
                    CountLabel(label: "单词书", title: "N/A")
                    CountLabel(label: "剩余", title: "N/A")
                    CountLabel(label: "每日计划", title: "N/A")
                }
                
                Button(action: pressBook) {
                    CountLabel(label: "选择>>", icon: "book")
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
        
        func handleFail() {
            self.message = "无法连接到服务器"
            wait.leave()
        }
        
        Remote.sendGetRequest(path: "/plan/list", handleSuccess: handleSuccess, token: Local.getToken(), handleFail: handleFail)
        
        wait.notify(queue: .main) {
            if self.status {
//                notification("获取单词书列表成功", .success)
            } else {
                notification("获取单词书列表失败: "+self.message, .danger)
            }
        }
    }
}

