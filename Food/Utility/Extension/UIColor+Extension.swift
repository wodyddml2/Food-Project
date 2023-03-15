//
//  UIColor+Extension.swift
//  Food
//
//  Created by J on 2022/10/06.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
 
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    static let darkPink = UIColor(rgb: 0xff3c85)
    
    static let lightPink = UIColor(rgb: 0xf8f3f3)
    
    static let background = UIColor(rgb: 0xf6f4f6)
}
