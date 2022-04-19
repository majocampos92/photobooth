//
//  SectionModel.swift
//  ChallengeCats
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
