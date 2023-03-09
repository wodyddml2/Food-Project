//
//  DetailViewController.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    
    let repository = UserWishListRepository()
    
    var webID: String?
    
    var storeData: StoreVO?
    var regionData: RegionVO?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func navigationSetup() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    @objc private func leftBarButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc private func rightBarButtonClicked() {
        guard let storeData = self.storeData else { return }
        if repository.fetchOverlap(address: storeData.adress, name: storeData.name).isEmpty {
            wishListRegister(storeData: storeData)
        } else {
            showCautionAlert(title: "이미 찜한 맛집입니다!")
        }
        
    }
    
    private func wishListRegister(storeData: StoreVO) {
        showMemoAlert(title: "찜 목록에 등록하시겠습니까?", button: "확인") { _ in
            if self.regionData != nil {
                guard let regionData = self.regionData else { return }
                
                let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(regionData.firstArea) \(regionData.secondArea)", storeAllAddress: storeData.adress)
                do {
                    try self.repository.addRealm(item: task)
                } catch {
                    self.showCautionAlert(title: "찜 목록 저장에 실패했습니다.")
                }
                
            } else {
                RequestSearchAPIManager.shared.requestAPI(type: RegionInfo.self, router: Router.region(lon: storeData.lat, lat: storeData.lon)) { region in
                    switch region {
                    case .success(let success):
                        let area = success.results[0].region.toDomain()
                        DispatchQueue.main.async {
                            let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(area.firstArea) \(area.secondArea)", storeAllAddress: storeData.adress)
                            do {
                                try self.repository.addRealm(item: task)
                            } catch {
                                self.showCautionAlert(title: "찜 목록 저장에 실패했습니다.")
                            }
                        }
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
            
        }
    }
    
    override func configureUI() {
        
        guard let webID = webID else { return }
        let url = URL(string: webID)
        
        guard let url = url else { return }
        let request = URLRequest(url: url)
        mainView.webView.load(request)
        
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let stopButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(stopButtonClicked))
        let gobackButton = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(gobackButtonClicked))
        let reloadButton = UIBarButtonItem(image: UIImage(systemName: "goforward"), style: .plain, target: self, action: #selector(reloadButtonClicked))
        let goFowardButton = UIBarButtonItem(image: UIImage(systemName: "greaterthan"), style: .plain, target: self, action: #selector(goFowardButtonClicked))
        
        let items: [UIBarButtonItem] = [stopButton, flexibleSpace, gobackButton, flexibleSpace, reloadButton, flexibleSpace, goFowardButton]
        mainView.toolBar.setItems(items, animated: true)
        mainView.toolBar.tintColor = .darkGray
    }
    
    @objc private func stopButtonClicked() {
        mainView.webView.stopLoading()
    }
    @objc private func gobackButtonClicked() {
        if mainView.webView.canGoBack {
            mainView.webView.goBack()
        }
    }
    @objc private func reloadButtonClicked() {
        mainView.webView.reload()
    }
    @objc private func goFowardButtonClicked() {
        if mainView.webView.canGoForward {
            mainView.webView.goForward()
        }
    }
    
    
}
