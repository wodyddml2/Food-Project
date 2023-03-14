//
//  OnboardingViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

import SnapKit

final class OnboardingBaseViewController: BaseViewController {
    
    private var pageViewControllerList: [UIViewController] = []
    
    private let pageContorl: UIPageControl = {
        let view = UIPageControl()
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .darkPink
        return view
    }()
    
    private let continueButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkPink
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
        let firstVC = OnboardingViewController(
            imageText: "first",
            titleText: "주변의 맛집을 검색해보세요",
            introText: "지도와 검색을 통해 주변의 맛집과 방문하고자하는 음식점을 찾아볼 수 있습니다")
        let secondVC = OnboardingViewController(
            imageText: "second",
            titleText: "나만의 찜 리스트에 구성해보세요",
            introText: "지도와 검색으로 찾아본 맛집을 나중에 찾아가기 쉽게 저장할 수 있습니다")
        let thirdVC = OnboardingViewController(
            imageText: "third",
            titleText: "맛집을 메모에 기록해보세요",
            introText: "나만의 맛집을 기록으로 남기고 얼마나 방문했는지 한 눈에 살펴볼 수 있습니다")
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

extension OnboardingBaseViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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
