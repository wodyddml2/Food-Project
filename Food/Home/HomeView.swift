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
    
    let memoListLabel: UILabel = {
        let view = UILabel()
        view.text = "Memo List"
        return view
    }()
    
    let memoListTableView: UITableView = {
        let view = UITableView()
        view.contentInset = .zero
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [bannerCollectionView, memoListLabel, memoListTableView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        bannerCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 4.5)
        }
        
        
        memoListLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(18)
            make.leading.equalTo(8)
        }
        
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(memoListLabel.snp.bottom).offset(15)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
