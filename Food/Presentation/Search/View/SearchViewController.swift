//
//  SearchViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    private var storeData: [StoreInfo] = []
    private var pageCount = 1
    
    let viewModel = SearchViewModel()
    
    var delegate: UserMemoDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.list.bind { store in
            DispatchQueue.main.async {
                self.mainView.searchTableView.reloadData()
            }
        }
    }
    
    override func configureUI() {
        searchControllerSetup()
        searchTableViewSetup()
    }
    
    override func navigationSetup() {
        navigationItem.title = "맛집 검색"
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .black
    }
   
    private func searchControllerSetup() {
        mainView.searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        mainView.searchController.searchBar.delegate = self
        mainView.searchController.searchResultsUpdater = self
    }
    
    private func searchTableViewSetup() {
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.prefetchDataSource = self
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        pageCount = 1

        viewModel.list.value.removeAll()
        
        viewModel.fetchSearch(query: searchBar.text ?? "", pageCount: pageCount) { store in
            DispatchQueue.main.async {
                if !store.isEmpty {
                    self.mainView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.storeNameLabel.text = viewModel.indexRow(index: indexPath.row).name
        cell.storeNumberLabel.text = viewModel.indexRow(index: indexPath.row).phone
        cell.storeLocationLabel.text = viewModel.indexRow(index: indexPath.row).adress

        cell.searchToDetailImageView.image = viewModel.memoCheck.value == true ? nil : UIImage(systemName: "chevron.right")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.memoCheck.value {
            delegate?.searchInfoMemo(
                storeName: viewModel.indexRow(index: indexPath.row).name,
                storeAdress: viewModel.indexRow(index: indexPath.row).adress
            )
            self.dismiss(animated: true)
        } else {
            let vc = DetailViewController()
            vc.webID = viewModel.list.value[indexPath.row].webID
            vc.storeData = viewModel.list.value[indexPath.row]
            transition(vc, transitionStyle: .presentFullNavigation)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.list.value.count - 1 == indexPath.row && viewModel.list.value.count < 45 {
                pageCount += 1

                viewModel.fetchSearch(query: mainView.searchController.searchBar.text ?? "", pageCount: pageCount) { _ in
                }
            }
        }

    }
}
