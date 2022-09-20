//
//  FixMemo.swift
//  Food
//
//  Created by J on 2022/09/20.
//

import UIKit

class FixMemoView: BaseView {
    
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
        view.layer.cornerRadius = 15
        view.image = UIImage(named: "dishes")
        view.backgroundColor = .lightGray
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    
    let storeLocationTextView: UITextView = {
        let view = UITextView()
        view.font = .boldSystemFont(ofSize: 16)
        view.textAlignment = .center
        return view
    }()
    
    let storeVisitLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        return view
    }()
    

    
    let storeReviewTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
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
        
        [ memoImageView, storeNameLabel, storeLocationTextView, stackView, storeVisitLabel, storeReviewTextView].forEach {
            self.addSubview($0)
        }
        starNumber = 5

    }
    
    func rateButtonSetup() {
        for i in 0 ..< 5 {
            let rateButton = UIButton()
            rateButton.isEnabled = false
            rateButton.setImage(starImage, for: .normal)
            rateButton.tintColor = .red
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
            make.top.equalTo(storeVisitLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(memoImageView.snp.width).multipliedBy(0.7)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(20)
            make.leading.lessThanOrEqualTo(memoImageView.snp.leading).offset(4)
            make.trailing.lessThanOrEqualTo(memoImageView.snp.trailing).offset(-4)
            make.centerX.equalTo(self)
        }
        
        storeLocationTextView.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
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
