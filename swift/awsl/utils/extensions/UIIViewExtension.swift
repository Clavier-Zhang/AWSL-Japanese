//
//  UIIViewExtension.swift
//  awsl
//
//  Created by clavier on 2019-10-23.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

extension UIView {

    func toUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
}
