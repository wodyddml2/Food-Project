//
//  WishListViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift

final class WishListViewController: BaseViewController {
    
    let viewModel = WishListViewModel()
    
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
        bind()
        
        navigationItem.title = "찜 목록"
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func configureUI() {
        view.addSubview(wishListCollectionView)
        wishListCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func setConstraints() {
        wishListCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.fetchData()
        viewModel.tasks.bind { _ in
            self.wishListCollectionView.reloadData()
        }
    }
}

extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCollectionViewCell.reusableIdentifier, for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.storeNameLabel.text = viewModel.indexItem(index: indexPath.item).storeName
        cell.storeLocationLabel.text = viewModel.indexItem(index: indexPath.item).storeAdress
        
        cell.storePickButton.tag = indexPath.item
        cell.storePickButton.addTarget(self, action: #selector(storePickButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func storePickButtonTapped(_ sender: UIButton) {
        viewModel.storePickButtonClicked(index: sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()

        vc.webID = viewModel.tasks.value[indexPath.item].storeURL
        
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
