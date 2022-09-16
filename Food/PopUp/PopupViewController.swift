//
//  PopupViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import Kingfisher

class PopupViewController: BaseViewController {
    let mainView = PopupView()
    
    var regionData: RegionInfo?
    var storeData: StoreInfo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
        
        mainView.popToMapButton.addTarget(self, action: #selector(popToMapButtonClicked), for: .touchUpInside)
        mainView.popToDetailButton.addTarget(self, action: #selector(popToDetailButtonClicked), for: .touchUpInside)
    }
    
    override func configureUI() {
        guard let regionData = regionData else {
            return
        }

        RequestSearchAPIManager.shared.requestStoreImage(query: "\(regionData.firstArea) \(regionData.secondArea) \(regionData.thirdArea) \(storeData?.name ?? "")") { image in
            DispatchQueue.main.async {
                self.mainView.storeImageView.kf.setImage(with: URL(string: image))
            }
            
        }
        mainView.storeNameLabel.text = storeData?.name
        mainView.storeLocationLabel.text = storeData?.adress
        mainView.storePhoneLabel.text = storeData?.phone
    }
    
    @objc func popToMapButtonClicked() {
        self.dismiss(animated: true)
    }
  
    @objc func popToDetailButtonClicked() {
        let vc = DetailViewController()
        vc.webID = storeData?.webID
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
}
