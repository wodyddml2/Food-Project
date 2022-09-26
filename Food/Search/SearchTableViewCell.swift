//
//  SearchTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 18)
        return view
    }()
    
    let storeNumberLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 13)
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.medium.rawValue, size: 13)
        return view
    }()
    
    
    let searchToDetailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .darkGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [storeNameLabel, storeNumberLabel, storeLocationLabel, searchToDetailImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        searchToDetailImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-12)
            make.width.equalTo(12)
            make.height.equalTo(18)
            make.centerY.equalTo(self)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(16)
            make.trailing.lessThanOrEqualTo(searchToDetailImageView.snp.leading).offset(4)
        }
        
        storeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(14)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNumberLabel.snp.bottom).offset(10)
            make.leading.equalTo(14)
            make.leading.lessThanOrEqualTo(searchToDetailImageView.snp.leading).offset(14)
            make.trailing.lessThanOrEqualTo(searchToDetailImageView.snp.leading).offset(-4)

        }
        
        
    }
}
