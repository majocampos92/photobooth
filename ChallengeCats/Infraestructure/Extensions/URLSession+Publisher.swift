//
//  URLSession+Publisher.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

extension URLSession {
    func publisher<T: Decodable>(for url: String) -> AnyPublisher<T, Error>? {
        guard let path = URL(string: url) else { return nil }

        return dataTaskPublisher(for: path)
            .map(\.data)
            .decode(
                type: T.self,
                decoder: JSONDecoder()
            )
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
