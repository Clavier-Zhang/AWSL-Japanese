//
//  ProgressBar.swift
//  awsl
//
//  Created by clavier on 2019-09-14.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    var done: CGFloat
    var remain: CGFloat
    var review: CGFloat
    var total: CGFloat
    
    init(_ done: Int, _ remain: Int, _ review: Int) {
        self.done = CGFloat(done)
        self.remain = CGFloat(remain)
        self.review = CGFloat(review)
        self.total = self.done + self.remain + self.review
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(green)
                        .frame(width: (self.done/self.total) * geometry.size.width)
                    Text(String(Int(self.done)))
                }
                
                ZStack {
                    Rectangle()
                        .fill(base)
                        .frame(width: (self.remain/self.total) * geometry.size.width)
                    Text(String(Int(self.remain)))
                }
                
                
                ZStack {
                    Rectangle()
                        .fill(yellow)
                        .frame(width: (self.review/self.total) * geometry.size.width)
                    Text(String(Int(self.review)))
                }
            }
        }
            .frame(height: 30)
    }
}
