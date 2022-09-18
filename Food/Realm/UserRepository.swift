//
//  UserRepository.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import Foundation

import RealmSwift

protocol UserWishListRepositoryType {
    func fecth() -> Results<UserWishList>
}

class UserWishListRepository: UserWishListRepositoryType {
    
    let localRealm = try! Realm()
    
    func fecth() -> Results<UserWishList> {
        return localRealm.objects(UserWishList.self)
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let imageDirectory = documentDirectory.appendingPathComponent("Image")
        let fileURL = imageDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func addRealm(item: UserWishList) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("저장 불가")
        }
    }
    
    
    
    func deleteRecord(item: UserWishList) {
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch {
            print("삭제 안됨")
        }
        
    }
    
}
