//
//  MapCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

final class MapCollectionViewCell: BaseCollectionViewCell {
    
    let storeListView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        view.textAlignment = .center
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureUI() {
        [storeListView, storeNameLabel, storeLocationLabel].forEach {
            self.addSubview($0)
        }
        self.shadowSetup(radius: 5)
    }
    
    override func setConstraints() {
        storeListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        storeNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(16)
            make.trailing.lessThanOrEqualTo(-4)
            make.leading.lessThanOrEqualTo(4)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-18)
            make.trailing.lessThanOrEqualTo(-4)
            make.leading.lessThanOrEqualTo(4)
        }
    }
}
