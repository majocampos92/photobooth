//
//  GalleryNetworkService.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Foundation
import Moya
import CombineMoya
import Combine


struct GalleryNetworkService: GalleryServiceType {
    
    private let api: MoyaProvider<GalleryAPI>

    init(provider: MoyaProvider<GalleryAPI>) {
        api = provider
    }
    
    /// Returns a cat list from API
    func getAll(params: CatParams) -> AnyPublisher<[CatResponseModel], Error> {
        api.requestPublisher(.getAll(params: params))
    }
    
    /// Returns a cat tag list from API
    func getTags() -> AnyPublisher<[String], Error> {
        api.requestPublisher(.getTags)
    }
}

extension MoyaProvider {
    /// Returns an AnyPublisher with data encoded to a specified model
    func requestPublisher<T: Decodable>(_ target: Target) -> AnyPublisher<T, Error> {
        self
            .requestPublisher(target)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
