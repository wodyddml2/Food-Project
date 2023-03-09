//
//  ViewModel.swift
//  Food
//
//  Created by J on 2022/10/11.
//

import Foundation

import RxSwift

final class SearchViewModel {
    var storeList: PublishSubject<[StoreVO]> = PublishSubject()
    
    var list: [StoreVO] = []
    
    var memoCheck: Bool = false
    
    func fetchSearch(query: String, pageCount: Int, completion: @escaping ([Document]) -> Void ) {
        RequestSearchAPIManager.shared.requestAPI(type: StoreInfo.self, router: Router.store(query: query, page: pageCount)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.list.append(contentsOf: result.documents.map {$0.toDomain()})
                self.storeList.onNext(self.list)
                completion(result.documents)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
