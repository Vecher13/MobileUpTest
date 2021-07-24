//
//  ResponseDataModel.swift
//  MobileUpTest
//
//  Created by Ash on 24.07.2021.
//

import Foundation

// MARK: - PhotoModelResponse
struct PhotoModelResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case userID = "user_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: TypeEnum
    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
