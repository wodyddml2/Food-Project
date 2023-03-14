//
//  FirstViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let mainView = OnboardingView()
    
    var imageText: String
    var titleText: String
    var introText: String
    
    init(imageText: String, titleText: String, introText: String) {
        self.imageText = imageText
        self.titleText = titleText
        self.introText = introText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        mainView.onboardingImageView.image = UIImage(named: imageText)
        mainView.onboardingTitleLabel.text = titleText
        mainView.onboardingIntroLabel.text = introText
    }
    
}
