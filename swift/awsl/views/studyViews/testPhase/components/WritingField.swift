//
//  WritingField.swift
//  awsl
//
//  Created by clavier on 2020-01-03.
//  Copyright © 2020 clavier. All rights reserved.
//

import SwiftUI

struct WritingField: View {
    
    // init
    var isCorrect : Binding<Bool>
    var label : Binding<String>
    
    @State var isPen : Bool = true
    @State var canvas : WritingPad?
    
    init(label: Binding<String>, isCorrect: Binding<Bool>) {
        self.label = label
        self.isCorrect = isCorrect
    }
    
    var body: some View {
        VStack {
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
                    Text(label.wrappedValue).padding()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, alignment: .leading)
                .background(base)
                .border(isCorrect.wrappedValue ? base : red)
                
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
    
    func recognize() {
        
        let writtenLabel = canvas!.getText()
        label.wrappedValue = writtenLabel
//        label = writtenLabel
        print("recog!"+writtenLabel)
    }
}

