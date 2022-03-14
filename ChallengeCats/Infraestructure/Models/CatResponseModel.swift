//
//  Cat.swift
//  ChallengeCats
//
//  Created by Jo on 5/3/22.
//

import Foundation

struct CatResponseModel: Codable {
    let id: String
    let createdAt: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case tags
    }
    
    /// Returns the cat image path
    func getImageUrl() -> String {
        "\(Constants.baseUrl)/cat/\(id)"
    }
}
