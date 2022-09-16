//
//  PopupView.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

class PopupView: BaseView {
    
    let popToMapButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let popupBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .blue
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textAlignment = .center
        return view
    }()
    
    
    let sectionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    let storePhoneLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    let popToDetailButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(arrayLiteral:  .layerMaxXMaxYCorner)
        view.setTitle("더보기", for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    
    let wishListButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(arrayLiteral:  .layerMinXMaxYCorner)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.setTitle("찜하기", for: .normal)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [popToMapButton, popupBackgroundView, storeImageView, storeNameLabel, sectionLineView, storeLocationLabel, storePhoneLabel, popToDetailButton, wishListButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        popToMapButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(popupBackgroundView.snp.top).offset(-12)
        }
        
        popupBackgroundView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-12)
            make.width.equalTo(UIScreen.main.bounds.width / 1.5)
            make.height.equalTo(UIScreen.main.bounds.height / 2.1)
        }
        
        storeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(popupBackgroundView)
            make.top.equalTo(popupBackgroundView.snp.top).offset(16)
            make.width.equalTo(popupBackgroundView.snp.width).multipliedBy(0.8)
            make.height.equalTo(popupBackgroundView.snp.height).multipliedBy(0.4)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.bottom).offset(16)
            make.centerX.equalTo(popupBackgroundView)
            make.trailing.lessThanOrEqualTo(storeImageView.snp.trailing).offset(-4)
            make.leading.lessThanOrEqualTo(storeImageView.snp.leading).offset(4)
        }
        
        storePhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
        sectionLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(storeImageView.snp.width)
            make.centerX.equalTo(popupBackgroundView)
            make.top.equalTo(storePhoneLabel.snp.bottom).offset(12)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLineView.snp.bottom).offset(8)
            make.centerX.equalTo(self)
            make.leading.equalTo(sectionLineView.snp.leading).offset(4)
            make.trailing.equalTo(sectionLineView.snp.trailing).offset(-4)
        }
        
        popToDetailButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(popupBackgroundView)
            make.width.equalTo(popupBackgroundView.snp.width).multipliedBy(0.5)
            make.height.equalTo(popupBackgroundView.snp.height).multipliedBy(0.15)
        }
        wishListButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(popupBackgroundView)
            make.width.equalTo(popupBackgroundView.snp.width).multipliedBy(0.5)
            make.height.equalTo(popupBackgroundView.snp.height).multipliedBy(0.15)
        }
    }
}
