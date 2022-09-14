//
//  SearchTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {

    let storeImageView: UIImageView = {
        let view = UIImageView()
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let storePickImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart.fill")
        view.tintColor = .red
        return view
    }()
    
    let storePickButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    
    let storeNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.text = "Dining J"
        return view
    }()
    
    let storeNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "0000-0000"
        return view
    }()
    
    let storeLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "서울특별시 서대문구 연희동sdsdsdsddsfdfdfddffdfdfdfdfdfdfdffdfdfdfdfdfdfdfdfdfdfdfdfdfdfdf"
        view.numberOfLines = 0
        return view
    }()
    
    let storeRateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        return view
    }()
    
    let storeRateLabel: UILabel = {
        let view = UILabel()
        view.text = "4.5"
        return view
    }()
    
    let storeVisitLable: UILabel = {
        let view = UILabel()
        view.text = "1번 방문하셨습니다!"
        return view
    }()
    
    let searchToDetailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [storeImageView, storePickImageView, storePickButton, storeNameLabel, storeNumberLabel, storeLocationLabel, searchToDetailImageView, storeRateImageView, storeRateLabel, storeVisitLable].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
            make.leading.equalTo(14)
            make.width.equalTo(self).multipliedBy(0.35)
        }
        
        storePickImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(storeImageView.snp.leading).offset(12)
            make.top.equalTo(storeImageView.snp.top).offset(14)
        }
        storePickButton.snp.makeConstraints { make in
            make.edges.equalTo(storeImageView)
        }
        
        searchToDetailImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-12)
            make.width.equalTo(12)
            make.height.equalTo(18)
            make.centerY.equalTo(self)
        }
        
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.top).offset(4)
            make.leading.equalTo(storeImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(searchToDetailImageView.snp.leading).offset(4)
        }
        
        storeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(storeImageView.snp.trailing).offset(8)
        }
        
        storeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(storeNumberLabel.snp.bottom).offset(10)
            make.leading.equalTo(storeImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(searchToDetailImageView.snp.leading).offset(-4)
            make.bottom.lessThanOrEqualTo(storeRateImageView.snp.top).offset(-4)
         }
        
        storeRateImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(storeImageView.snp.trailing).offset(8)
            make.bottom.equalTo(storeImageView.snp.bottom).offset(-4)
            
        }
        
        storeRateLabel.snp.makeConstraints { make in
            make.leading.equalTo(storeRateImageView.snp.trailing)
            make.centerY.equalTo(storeRateImageView)
        }
        
        storeVisitLable.snp.makeConstraints { make in
            make.trailing.equalTo(searchToDetailImageView.snp.leading).offset(-4)
            make.centerY.equalTo(storeRateImageView)
        }
        
    }
}
