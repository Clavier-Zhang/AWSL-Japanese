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
        
        task.submitted = true
        Local.save(key: "task", obj: task)
        back()
    }
    

    
}

