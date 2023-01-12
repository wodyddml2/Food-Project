//
//  SettingTableViewCell.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    
    let settingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: SetFont.light.rawValue, size: 15)
        return view
    }()
    
    let settingImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func configureUI() {
        [settingLabel, settingImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        settingLabel.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerY.equalTo(self)
        }
        settingImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-12)
            make.centerY.equalTo(self)
        }
    }
}
