//
//  BaseViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureUI()
        setConstraints()
        navigationSetup()
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
    func navigationSetup() { }
    
    func showRequestServiceAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        [ok, cancel].forEach {
            alert.addAction($0)
        }
        
        self.present(alert, animated: true)
    }

    
    func showMemoAlert(title: String, button: String = "저장", completionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: button, style: .default, handler: completionHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [ok, cancel].forEach {
            alert.addAction($0)
        }
        self.present(alert, animated: true)
    }
    
    func showCautionAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
}
