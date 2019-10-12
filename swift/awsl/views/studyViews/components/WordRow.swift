//
//  AudioRow.swift
//  awsl
//
//  Created by clavier on 2019-10-10.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import AVFoundation

struct WordRow: View {
    
    // Audio player
    @State var player : AVAudioPlayer?
    
    var task: Task
    
    var withFurigara: Bool
    
    public init(task: Task, withFurigara: Bool) {
        self.withFurigara = withFurigara
        self.task = task
    }
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            Text(getText())
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            
            Button(action: pressAudio) {
                Divider()
                Image(systemName: "speaker")
                    .frame(width: 20)
                    .padding(.horizontal)
            }
            
            Spacer().frame(width: 10)
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(base)
    }
    
    func pressAudio() {
        self.player = try! AVAudioPlayer(data: self.task.getWord().audio)
        player?.play()
    }
    
    func getText() -> String {
        if (withFurigara) {
            return task.getWord().text + task.getWord().furigara
        }
        return task.getWord().text
    }
}
