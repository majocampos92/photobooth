//
//  TagsModel.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Foundation

struct SectionModel: Hashable {
    let id = UUID()
    let tag: String
    let images: [String]
}
