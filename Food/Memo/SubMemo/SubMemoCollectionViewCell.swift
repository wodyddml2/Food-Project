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
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMinYCorner, .layerMinXMinYCorner)
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        view.text = "TTTTTTssssssssssssssss Buger"
        return view
    }()
    
    let storeRateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    let storeRateLabel: UILabel = {
        let view = UILabel()
        view.text = "4.9"
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.text = "34번 방문하셨습니다!"
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.shadowSetup(radius: 15)
        [memoView, memoImageView, storeNameLabel, storeRateImageView, storeRateLabel, storeVisitLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        memoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        memoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self).multipliedBy(0.65)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(14)
            make.leading.equalTo(12)
            make.trailing.lessThanOrEqualTo(self)
        }
        
        storeRateImageView.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(12)
        }
        
        storeRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(storeRateImageView)
            make.leading.equalTo(storeRateImageView.snp.trailing)
        }
        
        storeVisitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.trailing.equalTo(-12)
        }
    }
}
