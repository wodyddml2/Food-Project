//
//  DetailView.swift
//  Food
//
//  Created by J on 2022/09/13.
//

import UIKit

class DetailView: BaseView {
    
    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.text = "sss"
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
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "ssdssdsdsdsfsfsfsdfsdfsdfsfsfsdfsdfsfsdfsfsfsdfsfsfsdfsd"
        view.numberOfLines = 0
        return view
    }()
    
    let storeHourOfOperationLabel: UILabel = {
        let view = UILabel()
        view.text = "영업시간 09:00"
        return view
    }()
    
    let storeNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "전화번호 0000-0000"
        return view
    }()
    
    let detailToMemoLabel: UILabel = {
        let view = UILabel()
        view.text = "메모에 추가"
        return view
    }()
    
    let detailToMemoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
    
    let detailToMemoButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeToolBar: UIToolbar = {
        let view = UIToolbar()
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [storeImageView, storeNameLabel, storeRateImageView, storeRateLabel, storeLocationLabel, storeHourOfOperationLabel, storeNumberLabel, detailToMemoLabel, detailToMemoImageView, detailToMemoButton, storeToolBar].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height / 3.6)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.bottom).offset(12)
            make.leading.equalTo(18)
        }
        
        storeRateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(storeNameLabel)
        }
        
        storeRateImageView.snp.makeConstraints { make in
            make.trailing.equalTo(storeRateLabel.snp.leading).offset(-4)
            make.centerY.equalTo(storeNameLabel)
            make.width.equalTo(14)
            make.height.equalTo(14)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(12)
            make.trailing.lessThanOrEqualTo(self).offset(-12)
        }
        
        storeHourOfOperationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeLocationLabel.snp.bottom).offset(12)
            make.leading.equalTo(12)
        }
        
        storeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(storeHourOfOperationLabel.snp.bottom).offset(12)
            make.leading.equalTo(12)
        }
        
        detailToMemoImageView.snp.makeConstraints { make in
            make.top.equalTo(storeNumberLabel.snp.bottom).offset(4)
            make.trailing.equalTo(-8)
            make.height.equalTo(14)
            make.width.equalTo(11)
        }
        
        detailToMemoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(detailToMemoImageView)
            make.trailing.equalTo(detailToMemoImageView.snp.leading).offset(-4)
        }
        
        detailToMemoButton.snp.makeConstraints { make in
            make.trailing.equalTo(detailToMemoImageView.snp.trailing)
            make.leading.equalTo(detailToMemoLabel.snp.leading)
            make.top.bottom.equalTo(detailToMemoImageView)
        }
        
        storeToolBar.snp.makeConstraints { make in
            make.trailing.leading.equalTo(self)
            make.top.equalTo(detailToMemoButton.snp.bottom).offset(8)
            make.height.equalTo(50)
        }
    }
}
