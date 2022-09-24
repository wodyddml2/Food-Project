//
//  MemoListCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

final class MemoListCollectionViewCell: BaseCollectionViewCell {
    let memoImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
        view.textColor = .darkGray
        view.textAlignment = .center
        return view
    }()
    
    let memoButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [memoImageView,memoLabel,memoButton].forEach {
            self.addSubview($0)
        }
     
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.2
        self.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
    }
    
    override func setConstraints() {
        memoImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
        }
        memoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(memoImageView)
            make.leading.lessThanOrEqualTo(memoImageView).offset(4)
            make.trailing.lessThanOrEqualTo(memoImageView).offset(-4)
            make.top.equalTo(memoImageView.snp.bottom).offset(8)
            make.bottom.equalTo(-8)
        }
    }
}
