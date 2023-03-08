//
//  SetFont.swift
//  Food
//
//  Created by J on 2022/10/06.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Light
        case Medium
        case SemiBold
        case Bold
    }
    static func gothicNeo(_ family: Family = .Medium, size: CGFloat = 16) -> UIFont {
        return .init(name: "AppleSDGothicNeo-\(family)", size: size)!
    }
}
