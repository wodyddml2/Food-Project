//
//  SecondViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

class SecondViewController: BaseViewController {

    private let mainView = PageView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
  


}
