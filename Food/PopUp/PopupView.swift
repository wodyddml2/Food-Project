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
        return view
    }()
    
    let popupBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .darkGray
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
        view.text = "??? Cafe"
        view.textAlignment = .center
        return view
    }()
    
    let storeRateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .red
        return view
    }()
    
    let storeRateLabel: UILabel = {
        let view = UILabel()
        view.text = "4.9"
        return view
    }()
    
    let storeReviewLabel: UILabel = {
        let view = UILabel()
        view.text = "리뷰 수 1,200"
        return view
    }()
    
    let sectionLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "서울시 영등포구 ㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴㅇㄴsdsdfdnfjsdbfksfhskljfjsdfksjdfksjfldskjfsdlkfjsdlkfjsdflksdjflksdfjsdlkfjsdlfkjsdflksjflsdkfjsdklfjsdflksdjflksdfjdsklfjsdlfksdjflksdjflkdsfjsdlkfjsdflsdjflsdkf"
        
        view.numberOfLines = 0
        return view
    }()
    
    let popToDetailButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        view.setTitle("더보기", for: .normal)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [popToMapButton, popupBackgroundView, storeImageView, storeNameLabel, storeRateImageView, storeRateLabel, storeReviewLabel, sectionLineView, storeLocationLabel, popToDetailButton].forEach {
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
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        storeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(popupBackgroundView)
            make.top.equalTo(popupBackgroundView.snp.top).offset(16)
            make.width.equalTo(popupBackgroundView.snp.width).multipliedBy(0.8)
            make.height.equalTo(popupBackgroundView.snp.height).multipliedBy(0.4)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.bottom).offset(12)
            make.centerX.equalTo(popupBackgroundView)
            make.trailing.lessThanOrEqualTo(storeImageView.snp.trailing).offset(-4)
            make.leading.lessThanOrEqualTo(storeImageView.snp.leading).offset(4)
        }
        
        storeRateImageView.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(storeImageView.snp.leading).offset(12)
            make.width.equalTo(14)
            make.height.equalTo(14)
        }
        
        storeRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(storeRateImageView)
            make.leading.equalTo(storeRateImageView.snp.trailing).offset(4)
        }
        
        storeReviewLabel.snp.makeConstraints { make in
            make.centerY.equalTo(storeRateImageView)
            make.trailing.equalTo(storeImageView.snp.trailing).offset(-12)
        }
        
        sectionLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(storeImageView.snp.width)
            make.centerX.equalTo(popupBackgroundView)
            make.top.equalTo(storeRateImageView.snp.bottom).offset(12)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLineView.snp.bottom).offset(12)
            make.leading.equalTo(sectionLineView.snp.leading).offset(4)
            make.leading.lessThanOrEqualTo(sectionLineView.snp.leading).offset(4)
            make.trailing.lessThanOrEqualTo(sectionLineView.snp.trailing).offset(-4)
            make.bottom.lessThanOrEqualTo(popToDetailButton.snp.top).offset(-12)
        }
        
        popToDetailButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(popupBackgroundView)
            make.height.equalTo(popupBackgroundView.snp.height).multipliedBy(0.1)
        }
    }
}
