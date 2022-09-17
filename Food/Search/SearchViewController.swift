//
//  SearchViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    var storeData: [StoreInfo] = []
    
    override func loadView() {
        self.view = mainView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        RequestSearchAPIManager.shared.requestStore(query: <#T##String#>, <#T##completionHandler: ([StoreInfo]) -> Void##([StoreInfo]) -> Void#>)
    }
    
    override func configureUI() {
        navigationItem.title = "맛집 검색"
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        
        mainView.searchController.searchBar.delegate = self
        mainView.searchController.searchResultsUpdater = self
        
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        RequestSearchAPIManager.shared.requestStore(query: searchBar.text ?? "", page: 1) { store in
            self.storeData = store
            DispatchQueue.main.async {
                self.mainView.searchTableView.reloadData()
                self.mainView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.storeNameLabel.text = storeData[indexPath.row].name
        cell.storeNumberLabel.text = storeData[indexPath.row].phone
        cell.storeLocationLabel.text = storeData[indexPath.row].adress
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainView.frame.height / 7
    }
    
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
