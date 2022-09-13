//
//  DetailViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

class DetailViewController: BaseViewController {
    
    let mainView = DetailView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    override func configureUI() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let homeButton = UIBarButtonItem(title: "홈", style: .plain, target: self, action: nil)
        let menuButton = UIBarButtonItem(title: "메뉴", style: .plain, target: self, action: nil)
        let reviewButton = UIBarButtonItem(title: "리뷰", style: .plain, target: self, action: nil)
        
        let items: [UIBarButtonItem] = [homeButton, flexibleSpace, menuButton, flexibleSpace, reviewButton]
        
        mainView.storeToolBar.setItems(items, animated: true)
    }
    
    @objc func leftBarButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        
    }
}
