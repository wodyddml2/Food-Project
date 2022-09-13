//
//  HomeView.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

class HomeView: BaseView {
    
    let bannerCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return view
    }()
    
    let bannerPageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [bannerCollectionView,bannerPageControl].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        bannerCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 4.5)
        }
        
        bannerPageControl.snp.makeConstraints { make in
            make.centerX.equalTo(bannerCollectionView)
            make.bottom.equalTo(bannerCollectionView.snp.bottom).offset(-20)
        }
    }
    
}
