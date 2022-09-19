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

protocol UserMemoListRepositoryType {
    func fecth() -> Results<UserMemo>
}

class UserMemoListRepository: UserMemoListRepositoryType {
 
    let localRealm = try! Realm()
    
    func fecth() -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self)
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
    
    func addRealm(item: UserMemo) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("저장 불가")
        }
    }
    
    
    
    func deleteRecord(item: UserMemo) {
//        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch {
            print("삭제 안됨")
        }
        
    }
    
    func fetchCategory(category: Int) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter("storeCategory == %@", category)
    }
    
    func fetchUpdate(completionHandler: @escaping () -> Void) {
        do {
            try localRealm.write {
                completionHandler()
            }
        } catch {
            print("error")
        }
    }
    
    
}
