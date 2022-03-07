//
//  ICatRepository.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import Combine

protocol ICatRepository {
    func getAll(query: String) -> AnyPublisher<[CatResponseModel], Error>?
    func get() -> AnyPublisher<CatResponseModel, Error>?
    func getTags() -> AnyPublisher<[String], Error>?
}
