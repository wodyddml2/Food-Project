//
//  SettingTableHeaderView.swift
//  Food
//
//  Created by J on 2022/09/28.
//

import UIKit

import SnapKit

final class SettingTableHeaderView: UITableViewHeaderFooterView {
    
    let headerLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .gothicNeo(size: 18)
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
