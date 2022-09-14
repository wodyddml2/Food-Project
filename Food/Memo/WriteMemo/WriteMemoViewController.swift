//
//  WriteMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit


// 별점, 텍스트 뷰 추가!

class WriteMemoViewController: BaseViewController {

    let mainView = WriteMemoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.storeNameTextView.isScrollEnabled = false
    }


}
