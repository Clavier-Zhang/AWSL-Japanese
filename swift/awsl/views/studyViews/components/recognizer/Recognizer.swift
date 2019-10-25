//
//  Recognizer.swift
//  awsl
//
//  Created by clavier on 2019-09-21.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import UIKit
import PencilKit
import VideoToolbox
import CoreGraphics


class HandwritingRecognizer {
    
    static let model = hiraganaModel()
    
    public static func hiragana(uiimage: UIImage) -> String {
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
        
        
        
//        let output = try? model.prediction(image: uiimage.toCVPixelBuffer())
//        if let output = output {
//            return output.classLabel
//        }
        return ""
    }

}
