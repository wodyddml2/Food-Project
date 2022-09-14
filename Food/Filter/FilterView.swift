//
//  FilterView.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import UIKit

import SnapKit

class FilterView: BaseView {
    let indicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5
        view.backgroundColor = .black
        return view
    }()
    
    let filterTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "지역"
        return view
    }()
    
    let cityTitleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let metropolitanCityTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "광역시도"
        view.textAlignment = .center
        return view
    }()
    
    let cityTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "시 군 구"
        view.textAlignment = .center
        return view
    }()
    
    let metropolitanCityTableView: UITableView = {
       let view = UITableView()
        
        return view
    }()
    
    let cityTableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    let choiceButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .lightGray
        view.setTitle("선택", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [indicatorView, filterTitleLabel, cityTitleBackgroundView, metropolitanCityTitleLabel, cityTitleLabel, metropolitanCityTableView, cityTableView, choiceButton].forEach {
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
        
        filterTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom).offset(12)
            make.centerX.equalTo(self)
        }
        
        cityTitleBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(filterTitleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalTo(self)
            make.height.equalTo(50)
        }
        
        metropolitanCityTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cityTitleBackgroundView)
            make.leading.equalTo(self).offset(UIScreen.main.bounds.width / 5)
        }
        
        cityTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cityTitleBackgroundView)
            make.trailing.equalTo(self).offset(-(UIScreen.main.bounds.width / 5))
        }
        
        choiceButton.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        metropolitanCityTableView.snp.makeConstraints { make in
            make.top.equalTo(cityTitleBackgroundView.snp.bottom)
            make.leading.equalTo(self)
            make.bottom.equalTo(choiceButton.snp.top)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(cityTitleBackgroundView.snp.bottom)
            make.trailing.equalTo(self)
            make.bottom.equalTo(choiceButton.snp.top)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
    }
}
