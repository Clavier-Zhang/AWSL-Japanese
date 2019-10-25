//
//  TestPhase.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI


struct TestPhase: View {
    
    @Binding var currentPhase : String
    
    @Binding var task: Task
    
    var canvas : WritingPad = WritingPad()
    
    @State var label: String = ""
    
    @State var images: [UIImage] = [UIImage]()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Explanation of the word
            MeaningRow(meanings: task.getWord().cn_meanings, type: task.getWord().cn_type)
            
            // Buttons
            HStack {
                
                WideButton(label: "提交", action: pressSubmit, center: true)
                
                WideButton(label: "不会拼", action: pressUnableToSpell, center: true)
                
            }
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                }
            }
            
            

            // Recognized text
            Text(label)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: .leading)
                .padding()
                .background(base)
        
            // Writing pad
            canvas.frame(width: 300, height: 100)

            // Instructions
            Text("在上方区域写出假名")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
    func pressSubmit() {
        print("submit")
        self.images = []
        
        let uiimage = self.canvas.getImage()
        
        let matrix = uiimage.toMatrix()
                
                // Get vertical projections
                var heights = [Int]()
                for i in 0..<matrix[0].count {
                    heights.append(0)
                    for j in 0..<matrix.count {
                        heights[i] += matrix[j][i]
                    }
                }
                
                // Get char intervals
                var intervals = [(begin: Int, end: Int)]()
                
                let minGap = 60
                
                var begin = -1
                var end = -1
                var blankCount = 0
                
                for i in 0..<heights.count {
                    // Scanning a char
                    if (begin >= 0) {
                        // Still in char
                        if (heights[i] > 0) {
                            end = i
                            blankCount = 0
                        // Get blank
                        } else {
                            // Not exceed max gap, continue
                            if (blankCount < minGap) {
                                blankCount += 1
                            // Exceed max gap, cut char
                            } else {
                                intervals.append((begin, end))
                                begin = -1
                                end = -1
                                blankCount = 0
                            }
                        }
                    // Scanning gap
                    } else {
                        // Meet the begin of char
                        if (heights[i] > 0) {
                            begin = i
                        // Still gap
                        } else {
                            
                        }
                    }
                }
        
        // Consider the last char
        if (begin > 0) {
            intervals.append((begin, end))
        }

                print(intervals)
                var rects = [CGRect]()
                // Get square chars
                for i in 0..<intervals.count {
                    // Get horizontal projections
                    var horizontalProjections = [Int]()
                    for row in 0..<matrix.count {
                        horizontalProjections.append(0)
                        for col in intervals[i].begin...intervals[i].end {
                            horizontalProjections[row] += matrix[row][col]
                        }
                    }
                    // Get top/bottom border
                    var top = 0
                    var bottom = matrix.count-1
                    while (horizontalProjections[top] == 0) {
                        top += 1
                    }
                    while (horizontalProjections[bottom] == 0) {
                        bottom -= 1
                    }
                    
                    // Get width/height of the char, expand to square
                    var width = intervals[i].end - intervals[i].begin + 1
                    var height = bottom - top + 1
                    let side = max(width, height)
                    print(side)
                    print((width, height))
                    // Expand height
                    while (height < side) {
                        if (top > 0) {
                            top -= 1
                        }
                        if (bottom < matrix.count-1) {
                            bottom += 1
                        }
                        height = bottom - top + 1
                    }
                    // Expand width
                    while (width < side) {
                        if (intervals[i].begin > 0) {
                            intervals[i].begin -= 1
                        }
                        if (intervals[i].end < heights.count-1) {
                            intervals[i].end += 1
                        }
                        width = bottom - top + 1
                    }
        //            print((width, height))
                    rects.append(CGRect(x: intervals[i].begin, y: top, width: side, height: side))
                    
                    
                }
        for rect in rects {
            images.append(uiimage.crop(rect))
        }
        
        
        
        
        let res = HandwritingRecognizer.hiragana(uiimage: self.canvas.getImage())
        self.label = res
    }
    
    func pressUnableToSpell() {
        print("spell fail")
        self.currentPhase = "LEARN"
    }
}


