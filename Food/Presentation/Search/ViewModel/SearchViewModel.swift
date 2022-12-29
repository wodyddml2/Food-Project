//
//  ViewModel.swift
//  Food
//
//  Created by J on 2022/10/11.
//

import Foundation

import RxSwift

final class SearchViewModel {
    var storeList: PublishSubject<[StoreInfo]> = PublishSubject()
    
    var list: CObservable<[StoreInfo]> = CObservable([])
    
    var memoCheck: CObservable<Bool> = CObservable(false)
    
    func fetchSearch(query: String, pageCount: Int, completion: @escaping ([StoreInfo]) -> Void ) {
        RequestSearchAPIManager.shared.requestStore(query: query, page: pageCount) { [weak self] store in
            guard let self = self else { return }
//            self.list.value.append(contentsOf: store)
            self.storeList.onNext(store)
            completion(store)
        }
    }
}

//extension SearchViewModel {
//    var numberOfRowsInSection: Int {
//        return list.value.count
//    }
//    
//    func indexRow(index: Int) -> StoreInfo {
//        return list.value[index]
//    }
//}
