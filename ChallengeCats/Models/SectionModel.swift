//
//  TagsModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 10/3/22.
//

import Foundation

struct SectionModel: Hashable {
    let id = UUID()
    let tag: String
    let images: [String]
}
