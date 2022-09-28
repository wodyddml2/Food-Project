//
//  FirstViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

final class FirstViewController: BaseViewController {
    
    private let mainView = PageView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureUI() {
        mainView.onboardingImageView.image = UIImage(named: "first")
        mainView.onboardingTitleLabel.text = "주변의 맛집을 탐색해보세요"
        mainView.onboardingIntroLabel.text = "지도와 검색을 통해 주변의 맛집과 방문하고자하는 음식점을 찾아볼 수 있습니다"
    }
    
}
