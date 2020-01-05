//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


struct TestPhase: View {
    
    @State var settings = Settings.get()
    
    @Binding var task: Task
    @Binding var currentPhase : String
    
    @State var isCorrect = true
    
    @State var label: String = ""
    @State var disableSubmit: Bool = false
    
    @State var isPen : Bool = true
    
    @State var canvas : WritingPad?
    
    var body: some View {
        VStack(spacing: 20) {
            
            MeaningRow(meanings: task.getWord().chinese_meanings, type: task.getWord().chinese_type)
            
            HStack {
                WideButton(label: "提交", action: pressSubmit, center: true).disabled(disableSubmit)
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
            }
            
            if settings.isHandwriting {
                
                HStack {
                    Button(action: switchTool) {
                        VStack {
                            if isPen {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .animation(.interactiveSpring())
                            } else {
                                Image("eraser")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .animation(.interactiveSpring())
                            }
                        }
                        .frame(width: 60, height: 60)
                    }
                    .background(base)
                    
                    HStack {
                        Text(label).padding()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                    .background(base)
                    .border(isCorrect ? base : red)
                    
                    Button(action: clean) {
                        VStack {
                            Image(systemName: "gobackward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .frame(width: 60, height: 60)
                    }
                    .background(base)
                }
                .frame(height: 60)
                
                
                // Writing pad
                canvas.frame(width: 700, height: 150)

                Text("在上方区域写出假名").font(.system(size: 14)).frame(minWidth: 0, maxWidth: .infinity)
                
                
            } else {
                KeyboardField(label: self.$label, isCorrect: self.$isCorrect, pressSubmit: self.pressSubmit, settings: self.settings)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .onAppear {
            self.canvas = WritingPad(isPen: self.$isPen)
        }
    }

    func clean() {
        canvas!.clean()
    }
    
    func switchTool() {
        canvas?.switchTool()
    }
    
    func pressSubmit() {
        disableSubmit = true
        
        // Determine solution
        var solution = ""
        // Handing writing, always label
        if settings.isHandwriting {
            solution = task.getWord().label
        // Keyboard
        } else {
            // Label
            if settings.isHiragana {
                solution = task.getWord().label
            // Romaji
            } else {
                solution = task.getWord().romaji
            }
        }
        
        
        // Determine answer
        if settings.isHandwriting {
            label = canvas!.getText()
        }
        var answer = label
        
        
        
        
        
        
        
        if (solution == label) {
            task.setCorrect()
            currentPhase = LEARN_PHASE
        } else {
            print("Wrong! Correct solution is " + solution)
            isCorrect = false
        }
        
        
        
        
        
        disableSubmit = false
    }
    
    func pressUnableToSpell() {
        task.setWrong()
        currentPhase = LEARN_PHASE
    }
}


