//
//  TabViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
        setupTabBarAppearence()
    }
    
    func setupTabBar(viewController: UIViewController, title: String, image: String, fillImage: String) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: fillImage)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        return navigationViewController
    }
    func configureTabBar() {
        let homeVC = setupTabBar(viewController: HomeViewController(), title: "Home", image: "house", fillImage: "house.fill")
        let mapVC = setupTabBar(viewController: MapViewController(), title: "Map", image: "map", fillImage: "map.fill")
        let searchVC = setupTabBar(viewController: SearchViewController(), title: "Search", image: "magnifyingglass.circle", fillImage: "magnifyingglass.circle.fill")
        let settingVC = setupTabBar(viewController: SettingViewController(), title: "Setting", image: "ellipsis.circle", fillImage: "ellipsis.circle.fill")
        
        setViewControllers([homeVC, mapVC, searchVC, settingVC], animated: true)
    }
 
    func setupTabBarAppearence() {
        let appearence = UITabBarAppearance()
        
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .darkGray
        tabBar.standardAppearance = appearence
        tabBar.tintColor = .white
    }

}
