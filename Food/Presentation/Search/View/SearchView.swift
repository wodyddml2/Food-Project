//
//  SearchView.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import SnapKit

final class SearchView: BaseView {
    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.setValue("취소", forKey: "cancelButtonText")
        return search
    }()
    
    let searchTableView: UITableView = {
        let view = UITableView()
        view.keyboardDismissMode = .onDrag
        view.rowHeight = 95
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [searchTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
