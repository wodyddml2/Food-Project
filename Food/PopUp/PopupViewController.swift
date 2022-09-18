//
//  PopupViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

import RealmSwift

final class PopupViewController: BaseViewController {
    private let mainView = PopupView()
    
    private let repository = UserWishListRepository()
    
    var regionData: RegionInfo?
    var storeData: StoreInfo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
        
        mainView.storeImageView.image = UIImage(named: "dishes")
        mainView.storeNameLabel.text = storeData?.name
        mainView.storeLocationLabel.text = storeData?.adress
        mainView.storePhoneLabel.text = storeData?.phone
        mainView.storeCategoryLabel.text = storeData?.category
        
        mainView.popToMapButton.addTarget(self, action: #selector(popToMapButtonClicked), for: .touchUpInside)
        mainView.popToDetailButton.addTarget(self, action: #selector(popToDetailButtonClicked), for: .touchUpInside)
        mainView.wishListButton.addTarget(self, action: #selector(wishListButtonClicked), for: .touchUpInside)
    }
    
    @objc private func popToMapButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc private func popToDetailButtonClicked() {
        let vc = DetailViewController()
        vc.webID = storeData?.webID
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc private func wishListButtonClicked() {
        guard let storeData = storeData else { return }
        
        guard let regionData = regionData else { return }
        
        let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(regionData.firstArea) \(regionData.secondArea)")
        
        repository.addRealm(item: task)
        
        self.dismiss(animated: true)
    }
}
