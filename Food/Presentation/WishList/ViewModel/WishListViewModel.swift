//
//  WishListViewModel.swift
//  Food
//
//  Created by J on 2022/10/12.
//

import UIKit


class WishListViewModel {
    private let repository = UserWishListRepository()
    
    var tasks = Observable([UserWishList]())
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
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCollectionViewCell.reusableIdentifier, for: indexPath) as? WishListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.storeNameLabel.text = tasks.value[indexPath.item].storeName
        cell.storeLocationLabel.text = tasks.value[indexPath.item].storeAdress
        
        cell.storePickButton.tag = indexPath.item
        cell.storePickButton.addTarget(self, action: #selector(storePickButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func storePickButtonClicked(_ sender: UIButton) {
        do {
            try repository.deleteRecord(item: tasks.value[sender.tag])
        } catch let error {
            print(error)
        }
        
        tasks.value.remove(at: sender.tag)
    }
}
