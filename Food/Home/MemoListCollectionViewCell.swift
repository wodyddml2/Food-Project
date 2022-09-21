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
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
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
    }
    
    override func setConstraints() {
        memoImageView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalTo(self)
        }
        memoLabel.snp.makeConstraints { make in
            make.center.equalTo(memoImageView)
            make.top.leading.lessThanOrEqualTo(memoImageView).offset(8)
            make.trailing.bottom.lessThanOrEqualTo(memoImageView).offset(-8)
        }
    }
}
