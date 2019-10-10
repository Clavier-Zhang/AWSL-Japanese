//
//  AskPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit
import Foundation

struct SelfEvaluationPhase: View {
    
    @Binding var currentPhase : String
    
    @State var task: Task
    
    @State var player : AVAudioPlayer?
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Spacer().frame(width: 20)
                Text(task.getWord().text)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                
                Button(action: pressAudio) {
                    Text("123")
//                    Divider()
//                    Image(systemName: "speaker")
//                        .frame(width: 20).padding(.horizontal)
                }
                
                Spacer().frame(width: 10)
            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(base)
            
            
            Button(action: pressAudio) {
                                Text("123")
            //                    Divider()
            //                    Image(systemName: "speaker")
            //                        .frame(width: 20).padding(.horizontal)
                            }
            

            WideButton(label: "太简单", action: pressEasy)
            
            Spacer().frame(height: 400)
            
            WideButton(label: "认识", action: pressKnow)
            
            WideButton(label: "不认识", action: pressNotKnow)

        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }
    
    func pressNotKnow() {
        print("not know")
    }
    
    func pressKnow() {
        self.currentPhase = "TEST"
        print("know")
    }
    
    func pressEasy() {
        print(task.getWord())
        print("easy")
    }
    
    func pressAudio() {
        print("audio")
    

            self.player = try! AVAudioPlayer(data: self.task.getWord().audio)

            player?.play()

    }

}

