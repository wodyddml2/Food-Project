//
//  ThirdViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

final class ThirdViewController: BaseViewController {
    
    private let mainView = PageView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func configureUI() {
        
        mainView.onboardingTitleLabel.text = "맛집을 메모에 기록해보세요"
        mainView.onboardingIntroLabel.text = "나만의 맛집을 기록으로 남기고 얼마나 방문했는지 한 눈에 살펴볼 수 있습니다"
    }
}
