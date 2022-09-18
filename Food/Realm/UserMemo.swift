//
//  UserMemo.swift
//  Food
//
//  Created by J on 2022/09/18.
//

import Foundation

import RealmSwift

enum CategoryEnum: Int, PersistableEnum {
    case korea
    case china
    case japen
    case us
    case asian
    case desert
    case alcohol
}

class UserMemo: Object {
    @Persisted var storeName: String
    @Persisted var storeAdress: String?
    @Persisted var storeRate: Int
    @Persisted var storeCategory: CategoryEnum
}
