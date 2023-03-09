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
    
    var regionData: RegionVO?
    var storeData: StoreVO?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0)
        
        mainView.storeNameLabel.text = storeData?.name
        mainView.storeLocationLabel.text = storeData?.adress
        mainView.storePhoneLabel.text = storeData?.phone
        mainView.storeCategoryLabel.text = storeData?.category
        
        mainView.backgroudViewButton.addTarget(self, action: #selector(backgroudViewButtonClicked), for: .touchUpInside)
        mainView.popToMapButton.addTarget(self, action: #selector(popToMapButtonClicked), for: .touchUpInside)
        mainView.popToDetailButton.addTarget(self, action: #selector(popToDetailButtonClicked), for: .touchUpInside)
        mainView.wishListButton.addTarget(self, action: #selector(wishListButtonClicked), for: .touchUpInside)
        
        guard let storeData = storeData else { return }
        
        if repository.fetchOverlap(address: storeData.adress, name: storeData.name).isEmpty {
            mainView.wishListButton.setTitle("찜하기", for: .normal)
        } else {
            mainView.wishListButton.setTitle("찜 취소", for: .normal)
        }
    }
    @objc private func backgroudViewButtonClicked() {
        self.dismiss(animated: false)
    }
    
    @objc private func popToMapButtonClicked() {
        self.dismiss(animated: false)
    }
    
    @objc private func popToDetailButtonClicked() {
        let vc = DetailViewController()
        vc.webID = storeData?.webID
        vc.storeData = storeData
        vc.regionData = regionData
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc private func wishListButtonClicked() {
        guard let storeData = storeData else { return }
        
        guard let regionData = regionData else { return }
        
        if repository.fetchOverlap(address: storeData.adress, name: storeData.name).isEmpty {
            let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(regionData.firstArea) \(regionData.secondArea)", storeAllAddress: storeData.adress)
            do {
                try self.repository.addRealm(item: task)
            } catch {
                self.showCautionAlert(title: "찜 목록 저장에 실패했습니다.")
            }
            mainView.wishListButton.setTitle("찜 취소", for: .normal)
            self.dismiss(animated: true)
        } else {
            guard let item = repository.fetchOverlap(address: storeData.adress, name: storeData.name).first else {return}
            do {
                try repository.deleteRecord(item: item)
            } catch {
                self.showCautionAlert(title: "찜 삭제를 실패했습니다.")
            }
            
            mainView.wishListButton.setTitle("찜하기", for: .normal)
        }
    }
}
