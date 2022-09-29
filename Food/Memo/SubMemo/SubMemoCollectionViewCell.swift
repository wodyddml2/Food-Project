//
//  SubMemoCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

final class SubMemoCollectionViewCell: BaseCollectionViewCell {
    
    let memoView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 14)
        
        return view
    }()
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 12)
        return view
    }()
  
    let storeRateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .red
        return view
    }()
    
    let storeRateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 12)
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 12)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        setBorder(borderWidth: 0.3)
        [memoView, memoImageView, storeNameLabel, storeLocationLabel,  storeRateImageView, storeRateLabel, storeVisitLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        memoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        memoImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(12)
            make.trailing.equalTo(-12)
        
            make.height.equalTo(memoImageView.snp.width)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(8)
            make.leading.equalTo(6)
            make.trailing.lessThanOrEqualTo(self)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(6)
            make.leading.equalTo(6)
            make.trailing.lessThanOrEqualTo(-6)
        }
        
        storeRateImageView.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.leading.equalTo(6)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        storeRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(storeRateImageView)
            make.leading.equalTo(storeRateImageView.snp.trailing)
        }
        
        storeVisitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(storeRateImageView)
            make.trailing.equalTo(-6)
        }
    }
}
