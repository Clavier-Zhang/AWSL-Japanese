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
    
    @State var player : AVAudioPlayer?
    
    var task: Task
    
    var withFurigara: Bool
    
    var text: String
    
    public init(task: Task, withFurigara: Bool) {
        self.withFurigara = withFurigara
        self.task = task
        self.text = task.getWord().text
        if (withFurigara) {
            self.text += (" " + "【" + task.getWord().label + "】" + "【" + task.getWord().romaji + "】")
        }
    }
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            // Text
            Text(text)
                .font(large)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            // Audio Button
            Button(action: playAudio) {
                Divider()
                Image(systemName: "speaker")
                    .frame(width: 20)
                    .padding(.horizontal)
                Spacer().frame(width: 10)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(base)
        .onAppear(perform: playAudio)
    }
    
    func playAudio() {
        if (!task.getWord().audio.isEmpty) {
            do {
                try player = AVAudioPlayer(data: task.getWord().audio)
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
            return task.getWord().text + task.getWord().label
        }
        return task.getWord().text
    }
    
}
