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
 
    let documentManager = DocumentManager()
    
    let localRealm = try! Realm()
    
    func fecth() -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self)
    }
    
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
        removeImageFromDocument(fileName: "\(item.objectId).jpg")
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch {
            print("삭제 안됨")
        }
        
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
    //
    func saveEncodedJsonToDocument() throws {

        let encodedJson = try encodeMemo(item: fecth())

        try documentManager.saveJsonToDocument(data: encodedJson)

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
        let jsonData = try documentManager.fetchJSONData()

        guard let decodedData = try decodeJSON(jsonData) else { return }

        try localRealm.write {
            localRealm.deleteAll()
            localRealm.add(decodedData)
        }
    }
}


protocol UserCategoryRepositoryType {
    func fecth() -> Results<UserCategory>
}

class UserCategoryRepository: UserCategoryRepositoryType {
    
    let localRealm = try! Realm()
    
    func fecth() -> Results<UserCategory> {
        return localRealm.objects(UserCategory.self)
    }
    
    func fetchCategory(category: ObjectId) -> Results<UserCategory> {
        return localRealm.objects(UserCategory.self).filter("objectId == %@", category)
    }
    
    func addRealm(item: UserCategory) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("저장 불가")
        }
    }
 
    func deleteRecord(item: UserCategory) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch {
            print("삭제 안됨")
        }
    }
}
