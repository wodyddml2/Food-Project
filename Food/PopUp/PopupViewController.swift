//
//  PopupViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

class PopupViewController: BaseViewController {
    let mainView = PopupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
        
        mainView.popToMapButton.addTarget(self, action: #selector(popToMapButtonClicked), for: .touchUpInside)
        mainView.popToDetailButton.addTarget(self, action: #selector(popToDetailButtonClicked), for: .touchUpInside)
    }
    
    @objc func popToMapButtonClicked() {
        self.dismiss(animated: true)
    }
  
    @objc func popToDetailButtonClicked() {
        let vc = UINavigationController(rootViewController: DetailViewController())
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}
