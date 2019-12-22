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
    
    var body: some View {
        VStack {
            HStack(spacing: 100) {
                CountLabel(label: "单词书", title: homeResponse.currentPlan)
                CountLabel(label: "剩余", count: homeResponse.currentPlanLeftWordCount)
                CountLabel(label: "每日计划", count: homeResponse.scheduledWordsCount)
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
        func handleSuccess(data: Data) -> Void {
            let res : PlanListResponse? = dataToObj(data: data)
            if let res = res {
                NSLog("BookListView: Fetch plan list data")
                if (res.status) {
                    planListResponse = res
                    toBookListView = true
                } else {
                    NSLog("BookListView: Fetch plan list data fail")
                }
            }
        }
        Remote.sendGetRequest(path: "/plan/list", handleSuccess: handleSuccess, token: Local.getToken())
    }
}

