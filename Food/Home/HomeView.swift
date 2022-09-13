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
    
    let wishListBackgroundView: UIView = {
        let view = UIView()
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.7
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    
    let wishListLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 35)
        view.text = "Wish List"
        return view
    }()
    let wishListButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    let memoListLabel: UILabel = {
       let view = UILabel()
        view.text = "Memo List"
        return view
    }()
    let memoListAllLabel: UILabel = {
        let view = UILabel()
         view.text = "전체보기"
         return view
    }()
    let memoListAllImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
    let memoListAllButton: UIButton = {
       let view = UIButton()
        
        return view
    }()
    
    let memoListTableView: UITableView = {
        let view = UITableView()
       
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [bannerCollectionView,bannerPageControl, wishListBackgroundView,memoListLabel,memoListAllLabel, memoListAllImageView ,memoListAllButton, wishListLabel, wishListButton, memoListTableView].forEach {
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
        
        wishListBackgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(30)
            make.width.equalTo(UIScreen.main.bounds.width / 1.3)
            make.height.equalTo(UIScreen.main.bounds.height / 10)
        }
        
        wishListLabel.snp.makeConstraints { make in
            make.center.equalTo(wishListBackgroundView)
        }
        
        wishListButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(wishListBackgroundView)
        }
        memoListLabel.snp.makeConstraints { make in
            make.top.equalTo(wishListBackgroundView.snp.bottom).offset(30)
            make.leading.equalTo(8)
        }
        
        memoListAllImageView.snp.makeConstraints { make in
            make.centerY.equalTo(memoListLabel)
            make.trailing.equalTo(-8)
            make.height.equalTo(18)
            make.width.equalTo(15)
        }
        memoListAllLabel.snp.makeConstraints { make in
            make.centerY.equalTo(memoListLabel)
            make.trailing.equalTo(memoListAllImageView.snp.leading).offset(-4)
        }
        
        memoListAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(memoListAllImageView.snp.trailing)
            make.leading.equalTo(memoListAllLabel.snp.leading)
            make.top.bottom.equalTo(memoListAllImageView)
        }
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(memoListLabel.snp.bottom).offset(15)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
