//
//  WishListCollectionViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RxSwift

final class WishListCollectionViewCell: BaseCollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightPink
        
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let storePickImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "xmark.circle.fill")
        view.tintColor = .darkPink
        return view
    }()
    
    let storePickButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = .gothicNeo(.SemiBold)
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = .gothicNeo(.SemiBold)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    override func configureUI() {
        
        setBorder(borderWidth: 0.3)

        [storeImageView, storePickImageView, storePickButton, storeNameLabel, storeLocationLabel].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
       
        storeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        storePickImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(storeImageView.snp.leading).offset(12)
            make.top.equalTo(storeImageView.snp.top).offset(14)
        }
        storePickButton.snp.makeConstraints { make in
            make.edges.equalTo(storePickImageView)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.lessThanOrEqualTo(4)
            make.trailing.lessThanOrEqualTo(-4)
            make.centerY.equalTo(self).offset(-20)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.lessThanOrEqualTo(4)
            make.trailing.lessThanOrEqualTo(-4)
            make.centerY.equalTo(self).offset(20)
        }
        
    }
}
