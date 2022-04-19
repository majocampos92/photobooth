//
//  TagsModel.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Foundation

struct SectionModel: Identifiable {
    let id = UUID()
    let tag: String
    let images: [Photo]
}

struct Photo: Identifiable {
    let id = UUID()
    let path: String
}
