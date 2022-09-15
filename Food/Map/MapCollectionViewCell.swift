//
//  MapCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

class MapCollectionViewCell: BaseCollectionViewCell {
    
    let storeListView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let storeListButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 5
        return view
    }()
   
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [storeListView, storeImageView, storeNameLabel, storeLocationLabel, storeListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeListView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self)
        }
        storeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(storeListView)
            make.leading.equalTo(storeListView.snp.leading).offset(10)
            make.width.equalTo(storeListView.snp.width).multipliedBy(0.3)
            make.height.equalTo(storeListView.snp.height).multipliedBy(0.8)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.top).offset(8)
            make.leading.equalTo(storeImageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(storeListView.snp.trailing).offset(-8)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(12)
            make.top.lessThanOrEqualTo(storeNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(storeImageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(storeListView.snp.trailing).offset(-8)
            make.bottom.lessThanOrEqualTo(storeImageView.snp.bottom)
        }
    }
}
