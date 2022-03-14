//
//  GalleryService.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Combine

protocol GalleryServiceType {
    func getAll(params: CatParams) -> AnyPublisher<[CatResponseModel], Error>
    func getTags() -> AnyPublisher<[String], Error>
}

struct GalleryService: GalleryServiceType {
    
    private let networkService: GalleryNetworkService
    
    init(service: GalleryNetworkService) {
        networkService = service
    }
    
    /// Returns a cat list from service
    func getAll(params: CatParams) -> AnyPublisher<[CatResponseModel], Error> {
        networkService.getAll(params: params)
    }
    
    /// Returns a cat tag list from service
    func getTags() -> AnyPublisher<[String], Error> {
        networkService.getTags()
    }    
}
