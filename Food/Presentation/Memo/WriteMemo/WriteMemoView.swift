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
    
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "amda")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let categoryTextField: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        view.attributedPlaceholder = NSAttributedString(string: "카테고리", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.cgColor])
        view.backgroundColor = .darkPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    let storeSearchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightPink
        return view
    }()
    let storeSearchButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .black
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightPink
        return view
    }()
    
    let storeNameField: UITextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 16)
        view.attributedPlaceholder = NSAttributedString(string: "음식점 상호명을 적어주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.cgColor])
        view.backgroundColor = .lightPink
        view.textAlignment = .left
        return view
    }()
    
    let storeLocationTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.text = TextViewPlaceholder.locationPlaceholder.rawValue
        view.textColor = .lightGray
        view.textAlignment = .left
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightPink
        return view
    }()
    
    lazy var storeReviewTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = TextViewPlaceholder.reviewPlaceholder.rawValue
        view.textColor = .lightGray
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightPink
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureUI() {
        [ memoImageView, categoryTextField ,storeSearchView , storeSearchButton, storeNameField, storeLocationTextView, stackView, storeReviewTextView].forEach {
            self.addSubview($0)
        }

        starNumber = 5
    }
    
    func rateButtonSetup() {
        for i in 0 ..< 5 {
            let rateButton = UIButton()
            rateButton.setImage(starImage, for: .normal)
            rateButton.tintColor = .darkPink
            rateButton.tag = i
            rateButtonArr += [rateButton]
            stackView.addArrangedSubview(rateButton)
            rateButton.addTarget(self, action: #selector(rateButtonClicked(sender:)), for: .touchUpInside)
        }
    }
    
    func rateUpdate(tag: Int) {
        for i in 0...tag {
            rateButtonArr[i].setImage(starFillImage, for: .normal)
        }
        for i in tag + 1 ..< starNumber {
            rateButtonArr[i].setImage(starImage, for: .normal)
        }
    }
    
    @objc private func rateButtonClicked(sender: UIButton) {
        let endTag = sender.tag
        
        rateUpdate(tag: endTag)
        
        currentRate = endTag + 1
    }
    
    
    override func setConstraints() {
        
        memoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(memoImageView.snp.width)
        }
        
        storeSearchView.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.centerX.equalTo(self)
        }
        
        storeSearchButton.snp.makeConstraints { make in
            make.trailing.equalTo(storeSearchView.snp.trailing)
            make.centerY.equalTo(storeNameField)
            make.height.equalTo(storeSearchView.snp.height)
            make.width.equalTo(storeSearchButton.snp.height)
        }
        
        storeNameField.snp.makeConstraints { make in
            
            make.leading.equalTo(storeSearchView.snp.leading).offset(4)
            make.top.equalTo(storeSearchView.snp.top)
            make.bottom.equalTo(storeSearchView.snp.bottom)
            make.trailing.equalTo(storeSearchButton.snp.leading)
            
        }
        
        storeLocationTextView.snp.makeConstraints { make in
            make.top.equalTo(storeNameField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(storeSearchView.snp.width)
            make.height.equalTo(35)
        }
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(storeLocationTextView.snp.bottom).offset(20)
            make.leading.equalTo(storeSearchView.snp.leading)
            make.height.equalTo(40)
            make.width.equalTo(storeSearchView.snp.width).multipliedBy(0.3)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(storeLocationTextView.snp.bottom).offset(20)
            make.centerY.equalTo(categoryTextField)
            make.leading.equalTo(categoryTextField.snp.trailing).offset(60)
            make.trailing.equalTo(storeSearchView.snp.trailing)
        }
        
        storeReviewTextView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(storeSearchView.snp.width)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
}
