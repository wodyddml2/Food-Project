//
//  CategoryTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/27.
//

import UIKit

import SnapKit

final class CategoryTableViewCell: BaseTableViewCell {
    
    let categoryLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        self.addSubview(categoryLabel)
    }

    override func setConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(14)
            make.trailing.lessThanOrEqualTo(-14)
        }
    }
}
