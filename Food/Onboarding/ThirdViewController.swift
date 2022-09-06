//
//  ThirdViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

class ThirdViewController: BaseViewController {

    let mainView = OnboardingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
    }
    

   

}
