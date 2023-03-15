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
        setTabBarAppearence()
    }
   
    private func setTabBarButton(viewController: UIViewController, title: String, image: String, fillImage: String) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: fillImage)
     
        let controller = UINavigationController(rootViewController: viewController)
        return controller
    }
    
    private func configureTabBar() {
        let homeVC = setTabBarButton(viewController: HomeViewController(), title: "홈", image: "house", fillImage: "house.fill")
        
        let mapVC = NetworkMonitor.shared.isConnected ?
        setTabBarButton(viewController: MapViewController(), title: "지도", image: "map", fillImage: "map.fill") :
        setTabBarButton(viewController: NotNetworkViewController(), title: "지도", image: "map", fillImage: "map.fill")
      
        let memoVC = setTabBarButton(viewController: SubMemoViewController(), title: "메모", image: "square.and.pencil", fillImage: "square.and.pencil")
        let settingVC = setTabBarButton(viewController: SettingViewController(), title: "설정", image: "ellipsis.circle", fillImage: "ellipsis.circle.fill")
        
        setViewControllers([homeVC, mapVC, memoVC, settingVC], animated: true)
    }
    
    private func setTabBarAppearence() {
        let tabBarAppearance = UITabBarItemAppearance()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        tabBarAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.gothicNeo(.Bold, size: 10)]
        appearance.stackedLayoutAppearance = tabBarAppearance
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
   
        tabBar.backgroundColor = .white
        tabBar.tintColor = .darkPink
    }
}
