//
//  WriteMemoView.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

final class WriteMemoView: BaseView {
    
    var starNumber: Int = 5 {
        didSet { rateButtonSetup() }
    }
    var currentRate: Int = 0
    
    var rateButtonArr: [UIButton] = []
    
    lazy var starImage: UIImage? = {
        return UIImage(systemName: "star")
    }()
    
    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill")
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    var visitCount: Int = 0 {
        didSet { visitButtonSetup() }
    }

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
        view.placeholder = "음식점 상호명을 적어주세요"
        view.tintColor = .lightGray
        view.textAlignment = .center
        return view
    }()
    
    let storeLocationTextView: UITextView = {
        let view = UITextView()
        view.font = .boldSystemFont(ofSize: 16)
        view.text = TextViewPlaceholder.locationPlaceholder.rawValue
        view.textColor = .lightGray
//        view.text = "부산광역시 강서구 녹산산단382로14번가길 10~29번지(송정동)'"
        view.textAlignment = .center
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        return view
    }()
    
    let storeVisitPlusButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let storeVisitMinusButton: UIButton = {
        let view = UIButton()
        view.tintColor = .red
        view.setBackgroundImage(UIImage(systemName: "minus.square.fill"), for: .normal)
        return view
    }()
    
    let storeReviewTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = TextViewPlaceholder.reviewPlaceholder.rawValue
        view.textColor = .lightGray
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
        
        [ memoImageView, storeNameField, storeLocationTextView, stackView, storeVisitLabel, storeVisitPlusButton, storeVisitMinusButton, storeReviewTextView].forEach {
            self.addSubview($0)
        }
        starNumber = 5
        visitCount = 0
    }
    
    func rateButtonSetup() {
        for i in 0 ..< 5 {
            let rateButton = UIButton()
            rateButton.setImage(starImage, for: .normal)
            rateButton.tintColor = .red
            rateButton.tag = i
            rateButtonArr += [rateButton]
            stackView.addArrangedSubview(rateButton)
            rateButton.addTarget(self, action: #selector(rateButtonClicked(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func rateButtonClicked(sender: UIButton) {
         let endTag = sender.tag

         for i in 0...endTag {
             rateButtonArr[i].setImage(starFillImage, for: .normal)
         }
         for i in endTag + 1 ..< starNumber {
             rateButtonArr[i].setImage(starImage, for: .normal)
         }
         currentRate = endTag + 1
     }
    
    func visitButtonSetup() {
        
        storeVisitPlusButton.addTarget(self, action: #selector(storeVisitPlusButtonClicked), for: .touchUpInside)
        storeVisitMinusButton.addTarget(self, action: #selector(storeVisitMinusButtonClicked), for: .touchUpInside)
        
        storeVisitLabel.text = "\(visitCount)번 방문"
    }
    
    @objc private func storeVisitPlusButtonClicked() {
        visitCount += 1
    }
    
    @objc private func storeVisitMinusButtonClicked() {
        if visitCount > 0 {
            visitCount -= 1
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
        
        storeReviewTextView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        
        
    }
}
