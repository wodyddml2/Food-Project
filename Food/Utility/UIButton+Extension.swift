//
//  UIButton+Extension.swift
//  Food
//
//  Created by J on 2022/09/18.
//

import UIKit

extension UIButton {
    func rateButtonUI() {
        self.setImage(UIImage(systemName: "star"), for: .normal)
        self.tintColor = .red
    }
}
