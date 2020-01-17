//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import KeyboardObserving


extension UIApplication {
    /// Checks if view hierarchy of application contains `UIRemoteKeyboardWindow` if it does, keyboard is presented
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}


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
    
    @State var test = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            if settings.isHandwriting {
                
                MeaningRow(meanings: task.getWord().getMeanings(), type: task.getWord().getType())
                
                HStack {
                    WideButton(label: "Submit".localized(), action: pressSubmit, center: true).disabled(disableSubmit)
                    WideButton(label: "Can Not Spell".localized(), action: pressUnableToSpell, center: true)
                }
                
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
                

                Text("Write Hiragana in this area".localized()).font(.system(size: 14)).frame(minWidth: 0, maxWidth: .infinity)
                
                
            } else {
                
                VStack(spacing: 20) {
                    
                    MeaningRow(meanings: task.getWord().getMeanings(), type: task.getWord().getType(), hasKeyboard: true)
                    
                    HStack {
                        WideButton(label: "Submit".localized(), action: pressSubmit, center: true).disabled(disableSubmit)
                        WideButton(label: "Can Not Spell".localized(), action: pressUnableToSpell, center: true)
                    }
                    
                    TextField("Please enter ".localized()+(settings.isHiragana ? "Hiragana/Katakana".localized() : "Romaji".localized()), text: $label) {
                        self.pressSubmit()
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                    .background(base)
                    .border(isCorrect ? base : red)
                    .disableAutocorrection(true)
                    .autocapitalization(UITextAutocapitalizationType.none)
                    
                    Spacer().frame(height:120)
                    
                }
                    
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                
                
            }
//            Spacer().frame(height:220)
        }
        .keyboardObserving()
                    
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
        var kanjiSolution = "$#%^@$%"
        // Handing writing, always label
        if settings.isHandwriting {
            solution = task.getWord().label
        // Keyboard
        } else {
            // Label
            if settings.isHiragana {
                solution = task.getWord().label
                kanjiSolution = task.getWord().text
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
        // Trim
        let answer = label.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if (solution == answer || kanjiSolution == answer) {
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


