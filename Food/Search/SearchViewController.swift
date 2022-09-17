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
    var pageCount = 1
    
    override func loadView() {
        self.view = mainView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        navigationItem.title = "맛집 검색"
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .darkGray

        mainView.searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        mainView.searchController.searchBar.delegate = self
        mainView.searchController.searchResultsUpdater = self
        
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.prefetchDataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        storeData.removeAll()
        pageCount = 1
        RequestSearchAPIManager.shared.requestStore(query: searchBar.text ?? "", page: pageCount) { store in
            self.storeData.append(contentsOf: store)
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
        let vc = DetailViewController()
        vc.webID = storeData[indexPath.row].webID
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainView.frame.height / 7
    }
    
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if storeData.count - 1 == indexPath.item && storeData.count < 45 {
                pageCount += 1
                RequestSearchAPIManager.shared.requestStore(query: mainView.searchController.searchBar.text ?? "", page: pageCount) { store in
                    self.storeData.append(contentsOf: store)
                    DispatchQueue.main.async {
                        self.mainView.searchTableView.reloadData()

                    }
                }
            }
        }
        
    }
}
