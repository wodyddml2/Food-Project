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

extension UIViewController {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardUp(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.2) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            } completion: { _ in
                
            }
        }
    }
    
    @objc func keyboardDown() {
        self.view.transform = .identity
    }
}

extension UIViewController {
    func addNavBarImage() -> UIImageView {
        
        let image = UIImage(named: "amda")
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
    
        return imageView
    }
}
