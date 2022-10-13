//
//  ViewModel.swift
//  Food
//
//  Created by J on 2022/10/11.
//

import UIKit

class SearchViewModel {
    var list: Observable<[StoreInfo]> = Observable([])
    
    var memoCheck: Observable<Bool> = Observable(false)
    
    func fetchSearch(query: String, pageCount: Int, completion: @escaping ([StoreInfo]) -> Void ) {
        RequestSearchAPIManager.shared.requestStore(query: query, page: pageCount) { [weak self] store in
            guard let self = self else { return }
            self.list.value.append(contentsOf: store)
            
            completion(store)
        }
    }
}

extension SearchViewModel {
    var numberOfRowsInSection: Int {
        return list.value.count
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.storeNameLabel.text = list.value[indexPath.row].name
        cell.storeNumberLabel.text = list.value[indexPath.row].phone
        cell.storeLocationLabel.text = list.value[indexPath.row].adress

        cell.searchToDetailImageView.image = memoCheck.value == true ? nil : UIImage(systemName: "chevron.right")

        return cell
    }
}
