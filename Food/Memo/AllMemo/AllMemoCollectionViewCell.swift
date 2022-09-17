//
//  AllCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import SnapKit

final class AllMemoCollectionViewCell: BaseCollectionViewCell {
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let memoCategoryLabel: UILabel = {
        let view = UILabel()
        view.text = "한식"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [memoImageView, memoCategoryLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        memoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        memoCategoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
