//
//  WriteMemoView.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

final class WriteMemoView: BaseView {
    
    let indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5
        view.backgroundColor = .black
        return view
    }()
    
    let saveAndResaveButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        return view
    }()
    
    let galleryAndDeleteButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        return view
    }()
    
    let memoImageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .blue
        return view
    }()
    
    let storeNameTextView: UITextView = {
        let view = UITextView()
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @objc func viewTapGesture() {
        self.endEditing(true)
    }
    override func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        self.addGestureRecognizer(tapGesture)
        [indicatorView, saveAndResaveButton, galleryAndDeleteButton, memoImageView, storeNameTextView, storeLocationTextView, storeVisitLabel, storeVisitPlusButton, storeVisitMinusButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.width.equalTo(30)
            make.height.equalTo(2)
            make.centerX.equalTo(self)
        }
        
        saveAndResaveButton.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.trailing.equalTo(-12)
            make.width.height.equalTo(30)
        }
        galleryAndDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(saveAndResaveButton)
            make.trailing.equalTo(saveAndResaveButton.snp.leading).offset(-8)
            make.width.height.equalTo(30)
        }
        
        storeVisitLabel.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom).offset(50)
            make.centerX.equalTo(self)
        }
        
        storeVisitMinusButton.snp.makeConstraints { make in
            make.centerY.equalTo(storeVisitLabel)
            make.trailing.equalTo(storeLocationTextView.snp.trailing).offset(-20)
            make.width.height.equalTo(30)
        }
        
        storeVisitPlusButton.snp.makeConstraints { make in
            make.centerY.equalTo(storeVisitLabel)
            make.trailing.equalTo(storeVisitMinusButton.snp.leading).offset(-8)
            make.width.height.equalTo(30)
        }
        
        memoImageView.snp.makeConstraints { make in
            make.top.equalTo(storeVisitLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(memoImageView.snp.width).multipliedBy(0.6)
        }
        
        storeNameTextView.snp.makeConstraints { make in
            make.top.equalTo(memoImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.height.equalTo(65)
        }
        
        storeLocationTextView.snp.makeConstraints { make in
            make.top.equalTo(storeNameTextView.snp.bottom).offset(4)
            make.centerX.equalTo(self)
            make.width.equalTo(memoImageView.snp.width)
            make.height.equalTo(50)
        }
        
        
    }
}
