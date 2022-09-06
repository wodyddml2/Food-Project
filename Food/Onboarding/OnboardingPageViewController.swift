//
//  OnboardingViewController.swift
//  Food
//
//  Created by J on 2022/09/05.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: AnyObject{
    func onBoardingPageViewController(didUpdatePageCount count: Int)
    func onBoardingPageViewController(didUpdatePageIndex index: Int)
}


class OnboardingPageViewController: BaseViewController {
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var pageViewControllerList: [UIViewController] = []
    
    let pageviewcontroller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
//        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createPageViewController()
//        configurePageViewController()

        
        onboardingDelegate?.onBoardingPageViewController(didUpdatePageCount: pageViewControllerList.count)
    }
    override func configureUI() {
        view.addSubview(pageviewcontroller.view)
        
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        
        pageViewControllerList = [firstVC, secondVC, thirdVC]
        
        self.pageviewcontroller.delegate = self
        self.pageviewcontroller.dataSource = self
//        firstVC.mainView.onboardingPageControl.numberOfPages = 3
        
        guard let firstView = pageViewControllerList.first else { return }
        
        pageviewcontroller.setViewControllers([firstView], direction: .forward, animated: true)
    }
    override func setConstraints() {
        pageviewcontroller.view.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
//    func createPageViewController() {
//        let firstVC = FirstViewController()
//        let secondVC = SecondViewController()
//        let thirdVC = ThirdViewController()
//        pageViewControllerList = [firstVC, secondVC, thirdVC]
//    }
//
//    func configurePageViewController() {
//        self.pageviewcontroller.delegate = self
//        self.pageviewcontroller.dataSource = self
//
//
//        guard let firstView = pageViewControllerList.first else { return }
//
//        pageviewcontroller.setViewControllers([firstView], direction: .forward, animated: true)
//    }
   

}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstView = pageviewcontroller.viewControllers?.first, let index = pageViewControllerList.firstIndex(of: firstView) {
            onboardingDelegate?.onBoardingPageViewController(didUpdatePageIndex: index)
            print(index)
        }
        
    }
    
}
