//
//  UserRepository.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import UIKit

import RealmSwift

protocol UserRepositoryType {
    associatedtype UserList
    associatedtype User
    
    func fetch() -> UserList
    
    func addRealm(item: User) throws
    
    func deleteRecord(item: User) throws
    
    func saveEncodedJsonToDocument() throws
    
    func decodeJSON(_ memoData: Data) throws -> [User]?
    
    func overwriteRealm() throws
}

class UserWishListRepository: UserRepositoryType {

    typealias UserList = Results<UserWishList>
    
    typealias User = UserWishList
    
    let localRealm = try! Realm()
    
    func fetch() -> RealmSwift.Results<UserWishList> {
        return localRealm.objects(UserWishList.self)
    }
    
    func fetchOverlap(address: String, name: String) -> Results<UserWishList> {
        return localRealm.objects(UserWishList.self).filter("storeAllAddress == %@ && storeName == %@", address, name)
    }
    
    func addRealm(item: UserWishList) throws {
        try localRealm.write {
            localRealm.add(item)
        }
    }
    
    func deleteRecord(item: UserWishList) throws {
            try localRealm.write {
                localRealm.delete(item)
            }
    }
    
    func saveEncodedJsonToDocument() throws {
        
        let encodedJson = try encodeWishList(item: fetch())
        
        try DocumentManager.shared.saveJsonToDocument(data: encodedJson, json: "wishlist.json")
        
    }
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "MM월 dd일 hh:mm:ss EEEE"
        return formatter
    }()
    
    func encodeWishList(item: Results<UserWishList>) throws -> Data {
        do {
            let encoder = JSONEncoder()
            
            encoder.dateEncodingStrategy = .formatted(formatter)
            
            let encodedData: Data = try encoder.encode(item)
            
            return encodedData
        } catch {
            throw DocumentError.jsonEncodeError
        }
    }
    
    func decodeJSON(_ memoData: Data) throws -> [UserWishList]? {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            let decodedData: [UserWishList] = try decoder.decode([UserWishList].self, from: memoData)
            
            return decodedData
        } catch {
            throw DocumentError.jsonDecodeError
        }
    }
    
    func overwriteRealm() throws {
        let jsonData = try DocumentManager.shared.fetchJSONData(json: "wishlist.json")
        
        guard let decodedData = try decodeJSON(jsonData) else { return }
        
        try localRealm.write {
            //            localRealm.deleteAll()
            localRealm.add(decodedData)
        }
    }
}

class UserMemoListRepository: UserRepositoryType {
    
    typealias UserList = Results<UserMemo>
    
    typealias User = UserMemo
    
    
    func fetch() -> RealmSwift.Results<UserMemo> {
        return localRealm.objects(UserMemo.self)
    }
    
    
    let localRealm = try! Realm()
    
    
    func fetchCategory(category: ObjectId) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter("storeCategory == %@", category)
    }
    
    
    func fetchCategorySort(sort: String, category: ObjectId) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter("storeCategory == %@", category).sorted(byKeyPath: sort, ascending: false)
    }
    
    func fetchSort(sort: String) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).sorted(byKeyPath: sort, ascending: false)
    }
    
    func fetchSameData(storeAdress: String) -> Int {
        return localRealm.objects(UserMemo.self).filter("storeAdress == %@", storeAdress).count
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
    
    func addRealm(item: UserMemo) throws {
        try localRealm.write {
            localRealm.add(item)
        }
    }
    
    func deleteRecord(item: UserMemo) throws {
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
        try localRealm.write {
            localRealm.delete(item)
        }
    }
    
    
    func fetchUpdate(completionHandler: @escaping () -> Void) throws {
        try localRealm.write {
            completionHandler()
        }
    }
    //
    func saveEncodedJsonToDocument() throws {
        
        let encodedJson = try encodeMemo(item: fetch())
        
        try DocumentManager.shared.saveJsonToDocument(data: encodedJson, json: "memo.json")
        
    }
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "MM월 dd일 hh:mm:ss EEEE"
        return formatter
    }()
    
    func encodeMemo(item: Results<UserMemo>) throws -> Data {
        do {
            let encoder = JSONEncoder()
            
            encoder.dateEncodingStrategy = .formatted(formatter)
            
            let encodedData: Data = try encoder.encode(item)
            
            return encodedData
        } catch {
            throw DocumentError.jsonEncodeError
        }
    }
    
    
    
    func decodeJSON(_ memoData: Data) throws -> [UserMemo]? {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            let decodedData: [UserMemo] = try decoder.decode([UserMemo].self, from: memoData)
            
            return decodedData
        } catch {
            throw DocumentError.jsonDecodeError
        }
    }
    
    func overwriteRealm() throws {
        let jsonData = try DocumentManager.shared.fetchJSONData(json: "memo.json")
        
        guard let decodedData = try decodeJSON(jsonData) else { return }
        
        try localRealm.write {
            localRealm.deleteAll()
            localRealm.add(decodedData)
        }
    }
}

class UserCategoryRepository: UserRepositoryType {
    typealias UserList = Results<UserCategory>
    
    typealias User = UserCategory
    
    func fetch() -> RealmSwift.Results<UserCategory> {
        return localRealm.objects(UserCategory.self)
    }
    
    let localRealm = try! Realm()

    func fetchCategory(category: ObjectId) -> Results<UserCategory> {
        return localRealm.objects(UserCategory.self).filter("objectId == %@", category)
    }
    
    func addRealm(item: UserCategory) throws {
        try localRealm.write {
            localRealm.add(item)
        }
    }
    
    func deleteRecord(item: UserCategory) throws {
        try localRealm.write {
            localRealm.delete(item)
        }
    }
    
    func saveEncodedJsonToDocument() throws {
        
        let encodedJson = try encodeCategory(item: fetch())
        
        try DocumentManager.shared.saveJsonToDocument(data: encodedJson, json: "category.json")
        
    }
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "MM월 dd일 hh:mm:ss EEEE"
        return formatter
    }()
    
    func encodeCategory(item: Results<UserCategory>) throws -> Data {
        do {
            let encoder = JSONEncoder()
            
            encoder.dateEncodingStrategy = .formatted(formatter)
            
            let encodedData: Data = try encoder.encode(item)
            
            return encodedData
        } catch {
            throw DocumentError.jsonEncodeError
        }
    }
    
    func decodeJSON(_ memoData: Data) throws -> [UserCategory]? {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            let decodedData: [UserCategory] = try decoder.decode([UserCategory].self, from: memoData)
            
            return decodedData
        } catch {
            throw DocumentError.jsonDecodeError
        }
    }
    
    func overwriteRealm() throws {
        let jsonData = try DocumentManager.shared.fetchJSONData(json: "category.json")
        
        guard let decodedData = try decodeJSON(jsonData) else { return }
        
        try localRealm.write {
            //            localRealm.deleteAll()
            localRealm.add(decodedData)
        }
    }
}
