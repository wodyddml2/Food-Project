//
//  WishListModel.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import Foundation

import RealmSwift

class UserWishList: Object, Codable {
    @Persisted var storeName: String
    @Persisted var storeURL: String?
    @Persisted var storeAdress: String
    @Persisted var storeAllAddress: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(storeName: String, storeURL: String?, storeAdress: String, storeAllAddress: String) {
        self.init()
        self.storeName = storeName
        self.storeURL = storeURL
        self.storeAdress = storeAdress
        self.storeAllAddress = storeAllAddress
    }
    enum CodingKeys: String, CodingKey {
        case storeName
        case storeAdress
        case storeURL
        case storeAllAddress
        case objectId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(storeName, forKey: .storeName)
        try container.encode(storeAdress, forKey: .storeAdress)
        try container.encode(storeURL, forKey: .storeURL)
        try container.encode(storeAllAddress, forKey: .storeAllAddress)
    }
    
}
