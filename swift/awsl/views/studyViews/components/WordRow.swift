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
    
    var text: String
    
    public init(task: Task, withFurigara: Bool) {
        self.withFurigara = withFurigara
        self.task = task
        self.text = task.getWord().text
        if (withFurigara) {
            self.text += (" " + "【" + task.getWord().furigara + "】")
        }
    }
    
    var body: some View {
        HStack {
            // Text
            Text(text)
                .font(large)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
            // Audio Button
            Button(action: pressAudio) {
                Divider()
                Image(systemName: "speaker")
                    .frame(width: 20)
                    .padding(.horizontal)
            }

        }
            .padding(.horizontal)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(base)
            .onAppear(perform: pressAudio)
    }
    
    func pressAudio() {
        print(self.task.getWord())
        if (!self.task.getWord().audio.isEmpty) {
            do {
                try self.player = AVAudioPlayer(data: self.task.getWord().audio)
                player?.play()
            } catch {
                print("audio error")
            }
            
            
        } else {
            print("empty audio")
        }
        
    }
    
    func getText() -> String {
        if (withFurigara) {
            return task.getWord().text + task.getWord().furigara
        }
        return task.getWord().text
    }
    
}
