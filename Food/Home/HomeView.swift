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
    

    let memoListLabel: UILabel = {
       let view = UILabel()
        view.text = "Memo List"
        return view
    }()
//    let memoListAllLabel: UILabel = {
//        let view = UILabel()
//         view.text = "전체보기"
//         return view
//    }()
//    let memoListAllImageView: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: "chevron.right")
//        return view
//    }()
//    let memoListAllButton: UIButton = {
//       let view = UIButton()
//
//        return view
//    }()
    
    let memoListTableView: UITableView = {
        let view = UITableView()
       
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
        
//        memoListAllImageView.snp.makeConstraints { make in
//            make.centerY.equalTo(memoListLabel)
//            make.trailing.equalTo(-8)
//            make.height.equalTo(18)
//            make.width.equalTo(15)
//        }
//        memoListAllLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(memoListLabel)
//            make.trailing.equalTo(memoListAllImageView.snp.leading).offset(-4)
//        }
//
//        memoListAllButton.snp.makeConstraints { make in
//            make.trailing.equalTo(memoListAllImageView.snp.trailing)
//            make.leading.equalTo(memoListAllLabel.snp.leading)
//            make.top.bottom.equalTo(memoListAllImageView)
//        }
        memoListTableView.snp.makeConstraints { make in
            make.top.equalTo(memoListLabel.snp.bottom).offset(15)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
