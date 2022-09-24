//
//  UIView+Extension.swift
//  Food
//
//  Created by J on 2022/09/25.
//

import UIKit

extension UIView {
    func setBorder(borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = borderWidth
    }
}
