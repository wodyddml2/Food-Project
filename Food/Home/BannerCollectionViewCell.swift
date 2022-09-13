//
//  HomeCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

class BannerCollectionViewCell: BaseCollectionViewCell {
    
    let bannerImageView: UIImageView = {
       let view = UIImageView()
        
        return view
    }()
    
    let bannerIntroLable: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 35)
        view.textColor = .white
        view.text = "ssssss"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [bannerImageView, bannerIntroLable].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalTo(self)
        }
        bannerIntroLable.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
        }
    }
   
}
