//
//  TabViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        setupTabBarAppearence()
    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String, fillImage: String) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: fillImage)
        
        let navigationViewController = UINavigationController(rootViewController: viewController)
        return navigationViewController
    }
    
    private func configureTabBar() {
        let homeVC = setupTabBar(viewController: HomeViewController(), title: "Home", image: "house", fillImage: "house.fill")
        let mapVC = setupTabBar(viewController: MapViewController(), title: "Map", image: "map", fillImage: "map.fill")
        let memoVC = setupTabBar(viewController: AllMemoViewController(), title: "Memo", image: "square.and.pencil", fillImage: "square.and.pencil")
        let settingVC = setupTabBar(viewController: SettingViewController(), title: "Setting", image: "ellipsis.circle", fillImage: "ellipsis.circle.fill")
        
        setViewControllers([homeVC, mapVC, memoVC, settingVC], animated: true)
    }
    
    private func setupTabBarAppearence() {
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .white
        
        tabBar.standardAppearance = appearence
        tabBar.tintColor = .darkGray
    }
    
}
