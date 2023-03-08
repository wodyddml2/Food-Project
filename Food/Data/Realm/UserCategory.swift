//
//  UserCategory.swift
//  Food
//
//  Created by J on 2022/09/26.
//

import Foundation

import RealmSwift

class UserCategory: Object, Codable {
    @Persisted var category: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(category: String) {
        self.init()
        self.category = category
    }
    
    enum CodingKeys: String, CodingKey {
        case category
        case objectId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(objectId, forKey: .objectId)
        try container.encode(category, forKey: .category)
    }
}

