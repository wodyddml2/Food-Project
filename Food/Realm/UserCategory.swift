//
//  UserCategory.swift
//  Food
//
//  Created by J on 2022/09/26.
//

import Foundation

import RealmSwift

class UserCategory: Object {
    @Persisted var category: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(category: String) {
        self.init()
        self.category = category
    }
}

