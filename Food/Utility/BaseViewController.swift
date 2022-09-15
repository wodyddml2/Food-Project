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
        
    }
    
    func configureUI() { }
    
    func setConstraints() { }

    func showRequestLocationServiceAlert() {
        let alert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
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
    
    func showCautionAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
 
}
