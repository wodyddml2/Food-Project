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
    
    var storeData: StoreInfo?
    var regionData: RegionInfo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func navigationSetup() {
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    @objc private func leftBarButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc private func rightBarButtonClicked() {
        
        showMemoAlert(title: "찜 목록에 등록하시겠습니까?", button: "확인") { _ in
            guard let storeData = self.storeData else { return }
            if self.regionData != nil {
                guard let regionData = self.regionData else { return }
                
                let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(regionData.firstArea) \(regionData.secondArea)")
                
                self.repository.addRealm(item: task)
            } else {
                RequestSearchAPIManager.shared.requestRegion(lat: storeData.lon, lon: storeData.lat) { region in
                    DispatchQueue.main.async {
                        let task = UserWishList(storeName: storeData.name, storeURL: storeData.webID, storeAdress: "\(region.firstArea) \(region.secondArea)")
                        self.repository.addRealm(item: task)
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
