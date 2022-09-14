//
//  SearchView.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

class SearchView: BaseView {
    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        return search
    }()
    
    let searchTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    let storeSortLabel: UILabel = {
        let view = UILabel()
        view.text = "평점순"
        return view
    }()
    
    let storeSortImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.down")
        return view
    }()
    
    let storeSortButton: UIButton = {
        let view = UIButton()
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [storeSortLabel, storeSortImageView, storeSortButton, searchTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeSortLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(12)
        }
        storeSortImageView.snp.makeConstraints { make in
            make.width.equalTo(18)
            make.height.equalTo(storeSortLabel.snp.height).multipliedBy(0.6)
            make.leading.equalTo(storeSortLabel.snp.trailing)
            make.centerY.equalTo(storeSortLabel)
        }
        storeSortButton.snp.makeConstraints { make in
            make.top.equalTo(storeSortLabel.snp.top)
            make.height.equalTo(storeSortLabel.snp.height)
            make.leading.equalTo(storeSortLabel.snp.leading)
            make.trailing.equalTo(storeSortImageView.snp.trailing)
        }
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(storeSortButton.snp.bottom)
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
