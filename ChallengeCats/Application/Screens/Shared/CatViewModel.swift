//
//  CatViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

class CatViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    
    @Published var cats: [Cat] = []
    @Published private(set) var state = State.idle
    let catRepository: ICatRepository
    var disposables = Set<AnyCancellable>()
    
    init(repository: ICatRepository) {
        self.catRepository = repository
    }
    
    func getCats(query: String) {
        state = .loading
        catRepository.getAll(query: query)?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.state = .failed(failure)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { response in
                let mid = response.count / 2
                let mapper = response.enumerated()
                    .map { (index, item) in
                        Cat(
                            id: item.id,
                            url: self.getImageURL(id: item.id),
                            show: index == mid
                        )
                }
                self.cats = mapper
            }
        )
        .store(in: &disposables)
    }
    
    func getImageURL(id: String) -> URL? {
        URL(string: "\(Constants.baseUrl)cat/\(id)")
    }
}
