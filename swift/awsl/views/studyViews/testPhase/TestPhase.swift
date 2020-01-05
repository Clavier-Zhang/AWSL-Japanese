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
    
    @State var pads : [WritingPad] = []
    
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
                
                if pads.count > 0 {
                    VStack(spacing: 10) {
                        HStack {
                            ForEach(0..<9) { idx in
                                self.pads[idx].frame(width: 70, height: 70)
                            }
                        }
                        HStack {
                            ForEach(9..<18) { idx in
                                self.pads[idx].frame(width: 70, height: 70)
                            }
                        }
                    }
                }
                
//                canvas2.frame(width: 300, height: 150)
//                ForEach(0..<self.pads.count) { idx in
//                    self.pads[idx].frame(width: 100, height: 100)
//                }
                
//                List(pads) { pad in
//                    pad.frame(width: 300, height: 150)
//                }



                Text("在上方区域写出假名").font(.system(size: 14)).frame(minWidth: 0, maxWidth: .infinity)
                
                
            } else {
                KeyboardField(label: self.$label, isCorrect: self.$isCorrect, pressSubmit: self.pressSubmit, settings: self.settings)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .onAppear {
            // Handwrting pad mode
            if self.settings.isHandwriting {
                // Handwrting grid mode
                if self.settings.isGrid {
                    for _ in 0..<19 {
                        self.pads.append(WritingPad(isPen: self.$isPen))
                    }
                } else {
                    // non-grid mode
                    self.canvas = WritingPad(isPen: self.$isPen)
                }
            }
            
            
        }
    }

    func clean() {
        if settings.isGrid {
            for pad in pads {
                pad.clean()
            }
        } else {
            canvas!.clean()
        }
    }
    
    func switchTool() {
        if settings.isGrid {
            isPen.toggle()
            for pad in pads {
                pad.setTool(isPen: isPen)
            }
        } else {
            canvas?.switchTool()
        }
        
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
            if settings.isGrid {
                var temp = ""
                for pad in pads {
                    temp += pad.getOneText()
                }
                label = temp
            } else {
                label = canvas!.getText()
            }
        }
        var answer = label
        
        
        
        
        
        
        
        if (solution == answer) {
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


