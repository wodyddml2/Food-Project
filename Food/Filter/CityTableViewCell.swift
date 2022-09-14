//
//  CityTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import UIKit

class CityTableViewCell: BaseTableViewCell {

    let cityLabel: UILabel = {
        let view = UILabel()
        view.text = "중랑구"
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        self.addSubview(cityLabel)
    }
    
    override func setConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalTo(self)
        }
    }
}
