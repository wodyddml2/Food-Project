//
//  SearchViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let mainView = SearchView()
    
    private var pageCount = 1
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    var delegate: UserMemoDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bind()
    }
    
//    private func bind() {
//        viewModel.list.bind { store in
//            DispatchQueue.main.async {
//                self.mainView.searchTableView.reloadData()
//            }
//        }
//    }
    
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
        mainView.searchController.searchBar.delegate = self
        mainView.searchController.searchResultsUpdater = self
    }
    
   
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        pageCount = 1

        viewModel.list.removeAll()
        
        viewModel.fetchSearch(query: searchBar.text ?? "", pageCount: pageCount) { store in
            DispatchQueue.main.async {
                if !store.isEmpty {
                    self.mainView.searchTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    private func searchTableViewSetup() {
        viewModel.storeList
            .bind(to: mainView.searchTableView.rx.items(cellIdentifier: SearchTableViewCell.reusableIdentifier, cellType: SearchTableViewCell.self)) { index, info, cell in
            cell.storeNameLabel.text = info.name
            cell.storeNumberLabel.text = info.phone
            cell.storeLocationLabel.text = info.adress

            cell.searchToDetailImageView.image = self.viewModel.memoCheck.value == true ? nil : UIImage(systemName: "chevron.right")
        }
        .disposed(by: disposeBag)
        
        mainView.searchTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mainView.searchTableView.rx.modelSelected(StoreInfo.self)
            .withUnretained(self)
            .bind { vc, info in
                if vc.viewModel.memoCheck.value {
                    vc.delegate?.searchInfoMemo(
                        storeName: info.name,
                        storeAdress: info.adress
                    )
                    vc.dismiss(animated: true)
                } else {
                    let viewController = DetailViewController()
                    viewController.webID = info.webID
                    viewController.storeData = info
                    vc.transition(viewController, transitionStyle: .presentFullNavigation)
                }
            }
            .disposed(by: disposeBag)
        
        mainView.searchTableView.rx.prefetchRows
            .withUnretained(self)
            .bind (onNext: { vc, indexPaths in
                for indexPath in indexPaths {
                    if vc.viewModel.list.count - 1 == indexPath.row && vc.viewModel.list.count < 45 {
                        vc.pageCount += 1
                        
                        vc.viewModel.fetchSearch(query: vc.mainView.searchController.searchBar.text ?? "", pageCount: vc.pageCount) { _ in
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
