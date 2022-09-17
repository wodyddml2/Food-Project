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
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.7
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let memoLabel: UILabel = {
        let view = UILabel()
        view.text = "Sssssssssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsds"
        view.numberOfLines = 0
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
