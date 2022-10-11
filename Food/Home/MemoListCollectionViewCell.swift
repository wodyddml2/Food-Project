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
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 13)
        view.textColor = .darkGray
        view.textAlignment = .center
        return view
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [memoImageView, memoLabel].forEach {
            self.addSubview($0)
        }
     
        setBorder(borderWidth: 0.3)
        self.backgroundColor = .lightPink
    }
    
    override func setConstraints() {
        memoImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self)
            make.height.equalTo(memoImageView.snp.width)
        }
        memoLabel.snp.makeConstraints { make in
            make.leading.lessThanOrEqualTo(memoImageView).offset(4)
            make.trailing.lessThanOrEqualTo(memoImageView).offset(-4)
            make.top.equalTo(memoImageView.snp.bottom).offset(8)
        }
    }
}
