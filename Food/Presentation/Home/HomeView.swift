//
//  HomeView.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

final class HomeView: BaseView {
    
    let bannerCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return view
    }()
    
    let memoListTableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .singleLine
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
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
