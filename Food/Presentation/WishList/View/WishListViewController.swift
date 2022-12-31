//
//  WishListViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RxSwift
import RxCocoa

final class WishListViewController: BaseViewController {
    
    let viewModel = WishListViewModel()
    var disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
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
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = collectionViewLayout()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.wishList
            .bind(to: collectionView.rx.items(cellIdentifier: WishListCollectionViewCell.reusableIdentifier, cellType: WishListCollectionViewCell.self)) { index, info, cell in
                cell.storeNameLabel.text = info.storeName
                cell.storeLocationLabel.text = info.storeAdress
                
                cell.storePickButton.tag = index
                cell.storePickButton.rx.tap
                    .bind { _ in
                        
                    }
                    .disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        
        collectionView.rx.modelSelected(UserWishList.self)
            .withUnretained(self)
            .bind { vc, info in
                let viewController = DetailViewController()

                viewController.webID = info.storeURL
                
                vc.transition(viewController, transitionStyle: .presentFullNavigation)
            }
            .disposed(by: disposeBag)
    
        viewModel.fetchData()
    }
}

extension WishListViewController: UICollectionViewDelegate {

    
//    @objc private func storePickButtonTapped(_ sender: UIButton) {
//        viewModel.storePickButtonClicked(index: sender.tag)
//    }
    

    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2.5
        let spacing: CGFloat = 16
        
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
}
