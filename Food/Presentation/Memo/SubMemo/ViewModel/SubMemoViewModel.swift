//
//  SubMemoViewModel.swift
//  Food
//
//  Created by J on 2023/01/03.
//

import Foundation

import RealmSwift
import RxSwift

class SubMemoViewModel {
    var tasks: PublishSubject<Results<UserMemo>> = PublishSubject()
    
    var category: String?
    var categoryKey: ObjectId?
    private let repository = UserMemoListRepository()
    
    func fetch() {
        if let categoryKey = categoryKey {
            tasks.onNext(repository.fetchCategory(category: categoryKey))
        } else {
            tasks.onNext(repository.fetch())
        }
    }
    
}
