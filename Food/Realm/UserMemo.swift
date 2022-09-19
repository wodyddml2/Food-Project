//
//  UserMemo.swift
//  Food
//
//  Created by J on 2022/09/18.
//

import Foundation

import RealmSwift

class UserMemo: Object {
    @Persisted var storeName: String
    @Persisted var storeAdress: String?
    @Persisted var storeRate: Int
    @Persisted var storeVisit: Int
    @Persisted var storeReview: String
    @Persisted var storeCategory: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(storeName: String, storeAdress: String?, storeRate: Int, storeVisit: Int, storeReview: String,storeCategory: Int) {
        self.init()
        self.storeName = storeName
        self.storeAdress = storeAdress
        self.storeRate = storeRate
        self.storeVisit = storeVisit
        self.storeReview = storeReview
        self.storeCategory = storeCategory
    }
}
