//
//  HomeViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

class HomeViewController: BaseViewController {
    private let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
       
    }
    
    override func configureUI() {
        mainView.bannerCollectionView.delegate = self
        mainView.bannerCollectionView.dataSource = self
        mainView.bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reusableIdentifier)
        mainView.bannerCollectionView.isPagingEnabled = true
       
        mainView.bannerCollectionView.collectionViewLayout = bannerCollectionViewLayout()
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reusableIdentifier, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.item == 0 {
            bannerCell.bannerImageView.backgroundColor = .white
        } else {
            bannerCell.bannerImageView.backgroundColor = .lightGray
        }
        return bannerCell
    }
    func bannerCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: mainView.bannerCollectionView.frame.size.width, height: mainView.bannerCollectionView.frame.size.height) 이건 왜 안될까...??
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

}
