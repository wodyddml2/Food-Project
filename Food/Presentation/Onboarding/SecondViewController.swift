//
//  SecondViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

final class SecondViewController: BaseViewController {
    
    private let mainView = PageView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func configureUI() {
        mainView.onboardingImageView.image = UIImage(named: "second")
        mainView.onboardingTitleLabel.text = "나만의 찜 리스트에 구성해보세요"
        mainView.onboardingIntroLabel.text = "지도와 검색으로 찾아본 맛집을 나중에 찾아가기 쉽게 저장할 수 있습니다"
    }
}
