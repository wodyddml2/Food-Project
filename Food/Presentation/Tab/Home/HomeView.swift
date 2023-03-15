//
//  HomeView.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

final class HomeView: BaseView {
    
    lazy var bannerCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    let memoListTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.reusableIdentifier)
        view.register(MemoListTableHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoListTableHeaderView.reusableIdentifier)
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        view.backgroundColor = .background
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureUI() {
        [bannerCollectionView, memoListTableView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        bannerCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
