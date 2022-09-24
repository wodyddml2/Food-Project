//
//  HomeCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

final class BannerCollectionViewCell: BaseCollectionViewCell {
    
    let bannerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let bannerIntroLable: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.textColor = .white
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func configureUI() {
        [bannerImageView, bannerIntroLable].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bannerIntroLable.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.leading.lessThanOrEqualTo(self).offset(15)
        }
    }
}
