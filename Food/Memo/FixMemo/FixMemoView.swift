//
//  FixMemo.swift
//  Food
//
//  Created by J on 2022/09/20.
//


import UIKit

final class FixMemoView: BaseView {
    
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
        view.isEnabled = false
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 14)
        view.backgroundColor = UIColor(named: SetColor.darkPink.rawValue)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let storeSearchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
        return view
    }()

    let storeNameField: UITextField = {
        let view = UITextField()
        view.isEnabled = false
        view.font = UIFont(name: SetFont.medium.rawValue, size: 16)
        view.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
        view.textAlignment = .left
        return view
    }()
    
    let storeLocationTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.font = UIFont(name: SetFont.medium.rawValue, size: 16)
        view.text = TextViewPlaceholder.locationPlaceholder.rawValue
        view.textColor = .lightGray
        view.textAlignment = .left
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
        return view
    }()
    
    
    let storeReviewTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.font = UIFont(name: SetFont.medium.rawValue, size: 16)
        view.text = TextViewPlaceholder.reviewPlaceholder.rawValue
        view.textColor = .lightGray
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: SetColor.lightPink.rawValue)
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.semibold.rawValue, size: 18)
        view.textAlignment = .center
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
        
        [storeVisitLabel ,memoImageView, categoryTextField ,storeSearchView , storeNameField, storeLocationTextView, stackView, storeReviewTextView].forEach {
            self.addSubview($0)
        }
        starNumber = 5
    }

    func rateButtonSetup() {
        for i in 0 ..< 5 {
            let rateButton = UIButton()
            rateButton.isEnabled = false
            rateButton.setImage(starImage, for: .normal)
            rateButton.tintColor = UIColor(named: SetColor.darkPink.rawValue)
            rateButton.tag = i
            rateButtonArr += [rateButton]
            stackView.addArrangedSubview(rateButton)
          
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
 
    
    override func setConstraints() {
        storeVisitLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.centerX.equalTo(self)
        }
        memoImageView.snp.makeConstraints { make in
            make.top.equalTo(storeVisitLabel.snp.bottom).offset(10)
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
        
        storeNameField.snp.makeConstraints { make in
            
            make.leading.equalTo(storeSearchView.snp.leading).offset(4)
            make.top.equalTo(storeSearchView.snp.top)
            make.bottom.equalTo(storeSearchView.snp.bottom)
            make.trailing.equalTo(storeSearchView.snp.trailing).offset(-10)
            
        }
        
        storeLocationTextView.snp.makeConstraints { make in
            make.top.equalTo(storeNameField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(storeSearchView.snp.width)
            make.height.equalTo(50)
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
