//
//  MemoListTableHeaderView.swift
//  Food
//
//  Created by J on 2022/09/24.
//

import UIKit

import SnapKit

final class MemoListTableHeaderView: UITableViewHeaderFooterView {
    
    let categoryLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .gothicNeo(.SemiBold, size: 15)
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func headerConfig(color: UIColor = .background, text: String? = nil) {
        categoryLabel.text = text
        contentView.backgroundColor = color
    }
}
