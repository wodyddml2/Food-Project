//
//  NotNetworkViewController.swift
//  Food
//
//  Created by J on 2022/09/29.
//

import UIKit

import SnapKit

class NotNetworkViewController: BaseViewController {
    let networkLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 3
        view.text =
        """
        wifi 또는 셀룰러를 활성화 해준 후
        
        앱을 재부팅해주세요.
        """
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(networkLabel)
        
        networkLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
       
    }
    

 

}
