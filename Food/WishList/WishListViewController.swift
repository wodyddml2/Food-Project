//
//  WishListViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift

final class WishListViewController: BaseViewController {
    
    private let repository = UserWishListRepository()
    
    private var tasks: Results<UserWishList>? {
        didSet {
            wishListCollectionView.reloadData()
        }
    }
    
    private lazy var wishListCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(WishListCollectionViewCell.self, forCellWithReuseIdentifier: WishListCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tasks = repository.fecth()
    }
    
    override func configureUI() {
        view.addSubview(wishListCollectionView)
        
        navigationController?.navigationBar.tintColor = .black
        wishListCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func setConstraints() {
        wishListCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCollectionViewCell.reusableIdentifier, for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let tasks = tasks {
            cell.storeNameLabel.text = tasks[indexPath.item].storeName
            cell.storeLocationLabel.text = tasks[indexPath.item].storeAdress
        }
        
        cell.storePickButton.tag = indexPath.item
        cell.storePickButton.addTarget(self, action: #selector(storePickButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func storePickButtonClicked(_ sender: UIButton) {
        if let tasks = tasks {
            repository.deleteRecord(item: tasks[sender.tag])
        }
        wishListCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if let tasks = tasks {
            vc.webID = tasks[indexPath.item].storeURL
        }
        
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2.5
        let spacing: CGFloat = 16
        
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
}
