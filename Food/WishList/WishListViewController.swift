//
//  WishListViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class WishListViewController: BaseViewController {
    
    private lazy var wishListCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier: WishListCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wishListCollectionView.collectionViewLayout = collectionViewLayout()
       
    }
    
    override func configureUI() {
        view.addSubview(wishListCollectionView)
    }
    
    override func setConstraints() {
        wishListCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}

extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCollectionViewCell.reusableIdentifier, for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3.5
        let spacing: CGFloat = 8
        
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
}
