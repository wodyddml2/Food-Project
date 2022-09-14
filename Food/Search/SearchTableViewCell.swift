//
//  SearchTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {

    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let storePickImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let storePickButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let storeNumberLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let storeRateImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let storeRateLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let storeVisitLable: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let SearchToDetailImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [storeImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeImageView.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(10)
            make.leading.equalTo(10)
            make.width.equalTo(self).multipliedBy(0.3)
        }
    }
}
