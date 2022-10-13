//
//  UITextView+Extension.swift
//  Food
//
//  Created by J on 2022/10/11.
//

import UIKit

extension UITextView {
    func textViewNotPlaceholder() {
        if textColor == .lightGray {
            text = nil
            textColor = .black
        }
    }
    
    func textViewPlaceholder(placeholderText: String) {
        if self.text.isEmpty {
            text = placeholderText
            textColor = .lightGray
        }
        
    }
}
