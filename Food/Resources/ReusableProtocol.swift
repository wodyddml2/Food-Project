//
//  ReusableProtocol.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

protocol ReusableProtocol {
    static var reusableIdentifier: String { get }
}

extension UIViewController: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
