//
//  CatViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

class CatViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    let catRepository: ICatRepository
    var disposables = Set<AnyCancellable>()
    
    init(repository: ICatRepository) {
        self.catRepository = repository
    }
    
    func getCats(query: String) {
        catRepository.getAll(query: query)?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    print("Error \(failure)")
                case .finished:
                   print("Success!!")
                }
            }, receiveValue: { response in
                let mid = response.count / 2
                let mapper = response.enumerated()
                    .map { (index, item) in
                        Cat(
                            id: item.id,
                            url: URL(string: "\(Constants.baseUrl)cat/\(item.id)"),
                            show: index == mid
                        )
                }
                self.cats = mapper
            }
        )
        .store(in: &disposables)
    }
}
