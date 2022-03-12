//
//  GalleryNetworkService.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 10/3/22.
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
    
    func getAll(params: CatParams) -> AnyPublisher<[CatResponseModel], Error> {
        api.requestPublisher(.getAll(params: params))
    }
    
    func getTags() -> AnyPublisher<[String], Error> {
        api.requestPublisher(.getTags)
    }
}

extension MoyaProvider {
    func requestPublisher<T: Decodable>(_ target: Target) -> AnyPublisher<T, Error> {
        self
            .requestPublisher(target)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
