//
//  FirstViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

class FirstViewController: BaseViewController {
    
    private let mainView = PageView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
