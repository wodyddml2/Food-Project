//
//  FirstViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

class FirstViewController: BaseViewController {
    
    let mainView = OnboardingView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = OnboardingPageViewController()
        vc.onboardingDelegate = self
    }
    
}

extension FirstViewController: OnboardingPageViewControllerDelegate {
    func onBoardingPageViewController(didUpdatePageCount count: Int) {
        mainView.onboardingPageControl.numberOfPages = count
    }

    func onBoardingPageViewController(didUpdatePageIndex index: Int) {
        mainView.onboardingPageControl.currentPage = index
    }
}
