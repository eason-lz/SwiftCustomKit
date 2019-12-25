//
//  UIColor+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/11/14.
//  Copyright © 2019 eason. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - Public
    
    // MARK: Property
    public class var random: UIColor {
        let r = CGFloat(arc4random_uniform(255))
        let g = CGFloat(arc4random_uniform(255))
        let b = CGFloat(arc4random_uniform(255))
        return UIColor(r, g, b, 1)
    }
    
    /// 255 Color
    ///
    /// - Parameters:
    ///   - r: 0~255
    ///   - g: 0~255
    ///   - b: 0~255
    ///   - a: 0~1
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    public convenience init(_ rgba: Int64) {
        let r = CGFloat((rgba & 0xFF000000) >> 24)
        let g = CGFloat((rgba & 0x00FF0000) >> 16)
        let b = CGFloat((rgba & 0x0000FF00) >> 8)
        let a = CGFloat((rgba & 0x000000FF) >> 0)
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
    }
}
