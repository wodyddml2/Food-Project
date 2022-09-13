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
    
    let storeNameLable: UILabel = {
        let view = UILabel()
        view.text = "ssss"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let storeLocationLable: UILabel = {
        let view = UILabel()
        view.text = "SSSSssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [storeListView, storeImageView, storeNameLable, storeLocationLable, storeListButton].forEach {
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
        
        storeNameLable.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.top)
            make.leading.equalTo(storeImageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(storeListView.snp.trailing).offset(-8)
        }
        
        storeLocationLable.snp.makeConstraints { make in
            make.top.equalTo(storeNameLable.snp.bottom).offset(4)
            make.top.lessThanOrEqualTo(storeNameLable.snp.bottom).offset(4)
            make.leading.equalTo(storeImageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(storeListView.snp.trailing).offset(-8)
            make.bottom.lessThanOrEqualTo(storeImageView.snp.bottom)
        }
    }
}
