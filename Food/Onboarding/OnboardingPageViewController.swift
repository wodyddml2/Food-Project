//
//  OnboardingViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

import SnapKit

final class OnboardingPageViewController: BaseViewController {
    
    private var pageViewControllerList: [UIViewController] = []
    
    private let pageContorl: UIPageControl = {
        let view = UIPageControl()
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = UIColor(named: SetColor.darkPink.rawValue)
        return view
    }()
    
    private let continueButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(named: SetColor.darkPink.rawValue)
        view.setTitle("계속하기", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageViewController()
        configurePageViewController()
        
        pageContorl.numberOfPages = pageViewControllerList.count
        
        continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
    }
    
    private func createPageViewController() {
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        pageViewControllerList = [firstVC, secondVC, thirdVC]
    }
    
    private func configurePageViewController() {
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        guard let firstView = pageViewControllerList.first else { return }
        
        pageViewController.setViewControllers([firstView], direction: .forward, animated: true)
    }
    
    @objc private func continueButtonClicked() {
        
        if pageContorl.currentPage < pageViewControllerList.count - 1 {
            let nextPage = pageViewControllerList[pageContorl.currentPage + 1]
            pageContorl.currentPage += 1
            pageViewController.setViewControllers([nextPage], direction: .forward, animated: true)
        } else {
            
            UserDefaults.standard.set(true, forKey: "onboarding")
            
            transition(TabViewController(), transitionStyle: .presentFull)
        }
        
        if pageContorl.currentPage == 2{
            continueButton.setTitle("시작하기", for: .normal)
        }
        
    }
    
    
    override func configureUI() {
        [pageViewController.view, pageContorl, continueButton].forEach {
            view.addSubview($0)
        }
    }
    override func setConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        pageContorl.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-20)
            make.centerX.equalTo(view)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.centerX.equalTo(view)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.height.equalTo(50)
        }
   
    }
    
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let firstView = pageViewController.viewControllers?.first, let index = pageViewControllerList.firstIndex(of: firstView) else { return }
        
        pageContorl.currentPage = index
        
        if pageContorl.currentPage == 2 {
            continueButton.setTitle("시작하기", for: .normal)
        } else {
            continueButton.setTitle("계속하기", for: .normal)
        }
        
    }
    
}
