//
//  UserMemo.swift
//  Food
//
//  Created by J on 2022/09/18.
//

import Foundation

import RealmSwift

class UserMemo: Object, Codable {
    @Persisted var storeName: String
    @Persisted var storeAdress: String
    @Persisted var storeRate: Int
    @Persisted var storeVisit: Int
    @Persisted var storeReview: String
    @Persisted var storeCategory: ObjectId
    @Persisted var storeDate = Date()
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(storeName: String, storeAdress: String, storeRate: Int, storeVisit: Int, storeReview: String, storeCategory: ObjectId, storeDate: Date) {
        self.init()
        self.storeName = storeName
        self.storeAdress = storeAdress
        self.storeRate = storeRate
        self.storeVisit = storeVisit
        self.storeReview = storeReview
        self.storeCategory = storeCategory
        self.storeDate = storeDate
    }
    
    enum CodingKeys: String, CodingKey {
        case storeName
        case storeAdress
        case storeRate
        case storeVisit
        case storeReview
        case storeCategory
        case storeDate
        case objectId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(storeAdress, forKey: .storeAdress)
        try container.encode(storeName, forKey: .storeName)
        try container.encode(storeRate, forKey: .storeRate)
        try container.encode(storeVisit, forKey: .storeVisit)
        try container.encode(storeReview, forKey: .storeReview)
        try container.encode(storeCategory, forKey: .storeCategory)
        try container.encode(storeDate, forKey: .storeDate)
    }
    
    
}
