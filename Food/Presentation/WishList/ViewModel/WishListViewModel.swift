//
//  WishListViewModel.swift
//  Food
//
//  Created by J on 2022/10/12.
//
import Foundation

import RxSwift

final class WishListViewModel {
    private let repository = UserWishListRepository()
    
    var tasks = [UserWishList]()
    var wishList: PublishSubject<[UserWishList]> = PublishSubject()
}

extension WishListViewModel {
    func fetchData(){
        tasks.removeAll()
        let allWishList = repository.fetch()
        
        allWishList.forEach { value in
            tasks.append(value)
        }
        
        wishList.onNext(tasks)
    }
    
    func storePickButtonClicked(index: Int) {
        do {
            try repository.deleteRecord(item: tasks[index])
        } catch let error {
            print(error)
        }
        
        tasks.remove(at: index)
        wishList.onNext(tasks)
    }
}
