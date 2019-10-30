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
                    Local.save(key: "task", obj: task)
                    
                    print(res)
                    
                } else {
                    print("Status false")
                }
            }
        }
        
        let user : User? = Local.get(key: "user")
        
        if let user = user {
            
            SendPostRequest(path: "/task/submit", data: data, handleSuccess: handleSuccess, token: user.token)
        } else {
            print("BUG: User not in local")
            return
        }
        
        
        back()
        
        
        
        
    }
    

    

    
}

