//
//  FinishStudyView.swift
//  awsl
//
//  Created by clavier on 2019-10-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct SubmissionPhase: View {
    
    @State var task: Task = Local.getTask()
    
    @State var back: () -> Void

    var body: some View {
        VStack {
            
            Text("用时")
                
            RedButton(text: "提交", action: pressSubmit)
                
        }
            .frame(width: fullWidth, height: fullHeight+300)
            .background(base)
            .foregroundColor(fontBase)

    }
    
    func pressSubmit() {
        print("submit")
        
        // Make submission body
        
        task.clearData()
        
        let data = objToData(obj: task)
        
        func handleSuccess(data: Data) {
            let res : Response? = dataToObj(data: data)
            if let res = res {
                print("success submit task")
                if (res.status) {
                    task.submitted = true
                    task.save()
                    
                    print(res)
                    
                } else {
                    print("Status false")
                }
            }
        }
        
        Remote.sendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: Local.getToken())
        
        back()
        
        
        
        
    }
    

    

    
}

