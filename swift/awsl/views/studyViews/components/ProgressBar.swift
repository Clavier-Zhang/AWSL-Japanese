//
//  ProgressBar.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    var new: CGFloat
    var finished: CGFloat
    var review: CGFloat
    var total: CGFloat
    
    init(new: Int, finished: Int, review: Int) {
        self.new = CGFloat(new)
        self.finished = CGFloat(finished)
        self.review = CGFloat(review)
        self.total = self.new + self.finished + self.review
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing: 0) {
                
                ZStack {
                    Rectangle()
                        .fill(green)
                        .frame(width: (self.finished/self.total) * geometry.size.width)
                    Text(String(Int(self.finished)))
                }
                
                ZStack {
                    Rectangle()
                        .fill(base)
                        .frame(width: (self.new/self.total) * geometry.size.width)
                    Text(String(Int(self.new)))
                }
                
                
                ZStack {
                    Rectangle()
                        .fill(yellow)
                        .frame(width: (self.review/self.total) * geometry.size.width)
                    Text(String(Int(self.review)))
                }
                
            }
        }.frame(height: 30)
    }
}
