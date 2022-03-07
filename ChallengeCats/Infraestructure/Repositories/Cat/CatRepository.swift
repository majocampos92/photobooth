//
//  CatRepository.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import Combine

final class CatRepository: ICatRepository {

    let urlSession = URLSession.shared
    
    func getAll(query: String) -> AnyPublisher<[CatResponseModel], Error>? {
        urlSession.publisher(for: "\(Constants.baseUrl)api/cats?\(query)")
    }
    
    func get() -> AnyPublisher<CatResponseModel, Error>? {
        urlSession.publisher(for: "\(Constants.baseUrl)cat?json=true")
    }
    
    func getTags() -> AnyPublisher<[String], Error>? {
        urlSession.publisher(for: "\(Constants.baseUrl)api/tags")
    }
}
