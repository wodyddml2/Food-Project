//
//  WishListViewModel.swift
//  Food
//
//  Created by J on 2022/10/12.
//
import Foundation


final class WishListViewModel {
    private let repository = UserWishListRepository()
    
    var tasks = CObservable([UserWishList]())
}

extension WishListViewModel {
    func fetchData(){
        
        tasks.value.removeAll()
        
        let allWishList = repository.fetch()
        
        allWishList.forEach { wish in
            tasks.value.append(wish)
        }
    }
}

extension WishListViewModel {
    var numberOfInSection: Int {
        return tasks.value.count
    }
    
    func indexItem(index: Int) -> UserWishList {
        return tasks.value[index]
    }
    
    
    func storePickButtonClicked(index: Int) {
        do {
            try repository.deleteRecord(item: tasks.value[index])
        } catch let error {
            print(error)
        }
        
        tasks.value.remove(at: index)
    }
}
