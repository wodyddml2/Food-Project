//
//  ViewModel.swift
//  Food
//
//  Created by J on 2022/10/11.
//

import Foundation

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
    
    func indexRow(index: Int) -> StoreInfo {
        return list.value[index]
    }
}
