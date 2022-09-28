//
//  TabViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

enum SetColor: String {
    case lightPink
    case pink
    case darkPink
    case background
}

enum SetFont: String {
    case light = "AppleSDGothicNeo-Light"
    case medium = "AppleSDGothicNeo-Medium"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case bold = "AppleSDGothicNeo-Bold"
}

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
        let homeVC = setupTabBar(viewController: HomeViewController(), title: "홈", image: "house", fillImage: "house.fill")
        
        let mapVC = NetworkMonitor.shared.isConnected ? setupTabBar(viewController: MapViewController(), title: "지도", image: "map", fillImage: "map.fill") : setupTabBar(viewController: NotNetworkViewController(), title: "지도", image: "map", fillImage: "map.fill")
      
        let memoVC = setupTabBar(viewController: SubMemoViewController(), title: "메모", image: "square.and.pencil", fillImage: "square.and.pencil")
        let settingVC = setupTabBar(viewController: SettingViewController(), title: "설정", image: "ellipsis.circle", fillImage: "ellipsis.circle.fill")
        
        setViewControllers([homeVC, mapVC, memoVC, settingVC], animated: true)
    }
    
    private func setupTabBarAppearence() {
        let tabBarAppearance = UITabBarItemAppearance()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        tabBarAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: SetFont.bold.rawValue, size: 10)!]
        appearance.stackedLayoutAppearance = tabBarAppearance
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
   
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: SetColor.darkPink.rawValue)
    }
    
    
    
}
