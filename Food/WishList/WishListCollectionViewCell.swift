//
//  WishListCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class WishListCollectionViewCell: BaseCollectionViewCell {
    
    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let storePickImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "xmark.circle.fill")
        view.tintColor = .red
        return view
    }()
    
    let storePickButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.text = "상봉개성냉면"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "부산광역시 해운대구"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func configureUI() {
        [storeImageView, storePickImageView, storePickButton, storeNameLabel, storeLocationLabel].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        storeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        storePickImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(storeImageView.snp.leading).offset(12)
            make.top.equalTo(storeImageView.snp.top).offset(14)
        }
        storePickButton.snp.makeConstraints { make in
            make.edges.equalTo(storePickImageView)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.lessThanOrEqualTo(4)
            make.trailing.lessThanOrEqualTo(-4)
            make.centerY.equalTo(self).offset(-20)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.lessThanOrEqualTo(4)
            make.trailing.lessThanOrEqualTo(-4)
            make.centerY.equalTo(self).offset(20)
        }
        
    }
}
