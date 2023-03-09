//
//  RegionInfo.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import Foundation

// MARK: - RegionInfo
struct RegionInfo: Codable {
    let status: Status
    let results: [RegionResult]
}

// MARK: - Results
struct RegionResult: Codable {
    let name: String
    let code: Code
    let region: Region
}

// MARK: - Code
struct Code: Codable {
    let id, type, mappingID: String

    enum CodingKeys: String, CodingKey {
        case id, type
        case mappingID = "mappingId"
    }
}

// MARK: - Region
struct Region: Codable {
    let area0: Area
    let area1: Area1
    let area2, area3, area4: Area
}

extension Region {
    func toDomain() -> RegionVO {
        .init(firstArea: area1.alias, secondArea: area2.name, thirdArea: area3.name)
    }
}

// MARK: - Area
struct Area: Codable {
    let name: String
    let coords: Coords
}

// MARK: - Coords
struct Coords: Codable {
    let center: Center
}

// MARK: - Center
struct Center: Codable {
    let crs: CRS
    let x, y: Double
}

enum CRS: String, Codable {
    case empty = ""
    case epsg4326 = "EPSG:4326"
}

// MARK: - Area1
struct Area1: Codable {
    let name: String
    let coords: Coords
    let alias: String
}

// MARK: - Status
struct Status: Codable {
    let code: Int
    let name, message: String
}
