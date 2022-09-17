//
//  UIViewController+Extension.swift
//  Food
//
//  Created by J on 2022/09/18.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case present
        case presentFull
        case presentOverFull
        case presentFullNavigation
        case presentNavigation
        case push
    }

    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentFull:
            let vc = viewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case .presentOverFull:
            let vc = viewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            self.present(nav, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        
        }
    }
}
