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
    
    public static func recognizeOneHiragana(uiimage: UIImage) -> String {
        // Avoid blank image
        let matrix = uiimage.toMatrix()
        if (matrix.count == 0) {
            return ""
        }
        var result = ""
        let output = try? model.prediction(image: uiimage.toCVPixelBuffer())
        if let output = output {
            result += output.classLabel
        }
        return result
    }
    
    public static func hiragana(uiimage: UIImage) -> String {
        var result = ""
        let images = splitText(uiimage: uiimage)
        for image in images {
            let output = try? model.prediction(image: image.toCVPixelBuffer())
            if let output = output {
                result += output.classLabel
            }
        }
        return result
    }
    
    public static func splitText(uiimage: UIImage) -> [UIImage] {

        let matrix = uiimage.toMatrix()
        if (matrix.count == 0) {
            return [UIImage]()
        }
        // Get char intervals
        let intervals = getCharRanges(matrix: matrix);
        
        var rects = [CGRect]()
        // Get square chars
        for interval in intervals {
            var left = interval.begin
            var right = interval.end
            // Get horizontal projections
            var horizontalProjections = [Int]()
            for row in 0..<matrix.count {
                horizontalProjections.append(0)
                for col in left...right {
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
            var width = right - left + 1
            var height = bottom - top + 1
            let side = max(width, height)

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
                if (left > 0) {
                    left -= 1
                }
                if (right < matrix[0].count-1) {
                    right += 1
                }
                width = right - left + 1
            }

            rects.append(CGRect(x: left, y: top, width: side, height: side))
        }
        
        return uiimage.toUIImages(rects: rects)
    }
    
    private static func getCharRanges(matrix: [[Int]]) -> [(begin: Int, end: Int)] {
        // Get vertical projections
        var verticalProjections = [Int]()
        for i in 0..<matrix[0].count {
            verticalProjections.append(0)
            for j in 0..<matrix.count {
                verticalProjections[i] += matrix[j][i]
            }
        }
                
        // Get char intervals
        var intervals = [(begin: Int, end: Int)]()
                
        let minGap = 60
                
        var begin = -1
        var end = -1
        var blankCount = 0
                
        for i in 0..<verticalProjections.count {
            // Scanning a char
            if (begin >= 0) {
                // Still in char
                if (verticalProjections[i] > 0) {
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
                if (verticalProjections[i] > 0) {
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
        return intervals
    }
    

}
