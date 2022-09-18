//
//  WriteMemoView.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

final class WriteMemoView: BaseView {
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    let memoRateButton_1: UIButton = {
        let view = UIButton()
        view.rateButtonUI()
        return view
    }()
    let memoRateButton_2: UIButton = {
        let view = UIButton()
        view.rateButtonUI()
        return view
    }()
    let memoRateButton_3: UIButton = {
        let view = UIButton()
        view.rateButtonUI()
        return view
    }()
    let memoRateButton_4: UIButton = {
        let view = UIButton()
        view.rateButtonUI()
        return view
    }()
    let memoRateButton_5: UIButton = {
        let view = UIButton()
        view.rateButtonUI()
        return view
    }()
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .blue
        return view
    }()
    
    let storeNameField: UITextField = {
        let view = UITextField()
        view.font = .boldSystemFont(ofSize: 20)
        view.text = "부산광역시"
        view.textAlignment = .center
        //        view.layer.borderColor = UIColor.black.cgColor
        //        view.layer.borderWidth = 2
        return view
    }()
    
    let storeLocationTextView: UITextView = {
        let view = UITextView()
        view.font = .boldSystemFont(ofSize: 16)
        view.text = "부산광역시 강서구 녹산산단382로14번가길 10~29번지(송정동)'"
        view.textAlignment = .center
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.text = "888번 방문!!"
        view.textAlignment = .center
        return view
    }()
    
    let storeVisitPlusButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        return view
    }()
    
    let storeVisitMinusButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "minus.square.fill"), for: .normal)
        return view
    }()
    
    let memoTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @objc func viewTapGesture() {
        self.endEditing(true)
    }
    override func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        self.addGestureRecognizer(tapGesture)
        [ memoImageView, storeNameField, storeLocationTextView, stackView, storeVisitLabel, storeVisitPlusButton, storeVisitMinusButton, memoTextView].forEach {
            self.addSubview($0)
        }
        
        [memoRateButton_1, memoRateButton_2, memoRateButton_3, memoRateButton_4, memoRateButton_5].map {
            self.stackView.addArrangedSubview($0)
        }
        
    }
    
    override func setConstraints() {
      
        
        storeVisitLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.centerX.equalTo(self)
        }
        
        storeVisitMinusButton.snp.makeConstraints { make in
            make.centerY.equalTo(storeVisitLabel)
            make.trailing.equalTo(storeLocationTextView.snp.trailing).offset(-20)
            make.width.height.equalTo(25)
        }
        
        storeVisitPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(storeVisitLabel)
            make.trailing.equalTo(storeVisitMinusButton.snp.leading).offset(-8)
            make.width.height.equalTo(25)
        }
        memoImageView.snp.makeConstraints { make in
            make.top.equalTo(storeVisitLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(memoImageView.snp.width).multipliedBy(0.7)
        }
        
        storeNameField.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.height.equalTo(30)
        }
        
        storeLocationTextView.snp.makeConstraints { make in
            make.top.equalTo(storeNameField.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(storeLocationTextView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width).multipliedBy(0.8)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        
        
    }
}
