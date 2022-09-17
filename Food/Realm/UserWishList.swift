//
//  WishListModel.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import Foundation

import RealmSwift

class UserWishList: Object {
    @Persisted var storeName: String
    @Persisted var storeURL: String?
    @Persisted var storeAdress: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(storeName: String, storeURL: String?, storeAdress: String) {
        self.init()
        self.storeName = storeName
        self.storeURL = storeURL
        self.storeAdress = storeAdress
    }
}
