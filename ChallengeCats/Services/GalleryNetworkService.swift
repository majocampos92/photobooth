//
//  GalleryNetworkService.swift
//  ChallengeCats
//

import Foundation
import Moya
import Combine

protocol GalleryServiceType {
    func getAll(params: CatParams) -> AnyPublisher<[CatResponse], Error>
    func getTags() -> AnyPublisher<[String], Error>
}

struct GalleryNetworkService: GalleryServiceType {
    
    private let api: MoyaProvider<GalleryAPI>

    init(provider: MoyaProvider<GalleryAPI>) {
        api = provider
    }
    
    /// Returns a cat list from API
    func getAll(params: CatParams) -> AnyPublisher<[CatResponse], Error> {
        api.requestPublisher(.cats(params: params))
    }
    
    /// Returns a cat tag list from API
    func getTags() -> AnyPublisher<[String], Error> {
        api.requestPublisher(.tags)
    }
}
