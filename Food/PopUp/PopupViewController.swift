//
//  PopupViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import RealmSwift
import Kingfisher

class PopupViewController: BaseViewController {
    let mainView = PopupView()
    
    let repository = UserWishListRepository()
    
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
        mainView.wishListButton.addTarget(self, action: #selector(wishListButtonClicked), for: .touchUpInside)
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
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc func wishListButtonClicked() {
        guard let storeData = storeData else { return }
        
        guard let regionData = regionData else { return }
        
        let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(regionData.firstArea) \(regionData.secondArea)")
        
        do {
            try repository.localRealm.write {
                repository.localRealm.add(task)
            }
        } catch {
            print("저장 불가")
        }
        
        if let image = mainView.storeImageView.image {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
        }
        
      
        self.dismiss(animated: true)
    }
}
