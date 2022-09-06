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
 

}
