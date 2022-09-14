//
//  MetropolitanCityTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import UIKit

class MetropolitanCityTableViewCell: BaseTableViewCell {
    
    let metropolitanCityLabel: UILabel = {
        let view = UILabel()
        view.text = "서울시"
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        self.addSubview(metropolitanCityLabel)
    }
    
    override func setConstraints() {
        metropolitanCityLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalTo(self)
        }
    }
}
