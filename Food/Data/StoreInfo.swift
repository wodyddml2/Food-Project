//
//  StoreInfo.swift
//  Food
//
//  Created by J on 2022/09/15.
//
import Foundation

// MARK: - StoreInfo
struct StoreInfo: Codable {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable {
    let placeName, distance: String
    let placeURL: String
    let categoryName, addressName, roadAddressName, id: String
    let phone, categoryGroupCode, categoryGroupName, x: String
    let y: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case distance
        case placeURL = "place_url"
        case categoryName = "category_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case id, phone
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case x, y
    }
}

extension Document: Equatable {
    func toDomain() -> StoreVO {
        return .init(phone: phone, lat: Double(x)!, lon: Double(y)!, adress: addressName, name: placeName, webID: placeURL, category: categoryName)
    }
}

// MARK: - Meta
struct Meta: Codable {
    let sameName: JSONNull?
    let pageableCount, totalCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case sameName = "same_name"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
        case isEnd = "is_end"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {
    let region: [String]?
    let keyword: String?
    let selectedRegion: String?
    
    enum CodingKeys: String, CodingKey {
        case region, keyword
        case selectedRegion = "selected_region"
    }
}
