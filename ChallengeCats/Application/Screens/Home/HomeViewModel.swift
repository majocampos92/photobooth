//
//  ViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import Combine

final class HomeViewModel: CatViewModel {
    @Published var cat: URL?
    
    override init(repository: ICatRepository) {
        super.init(repository: repository)
        getCat()
        getCats(query: "limit=5")
    }
    
    func getCat() {
        catRepository.get()?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    print("Error \(failure)")
                case .finished:
                   print("Success!!")
                }
            }, receiveValue: { response in
                self.cat = self.getImageURL(id: response.id)
            }
        )
        .store(in: &disposables)
    }
    
    func getMid() -> Int {
        if cats.count > 0 {
            return cats.count / 2
        }
        return cats.count
    }
    
    func updateHeigth(value: Int) {
        var id: Int
        
        if value < 0 {
            id = -value + getMid()
        } else {
            id = getMid() - value
        }
        for position in 0..<cats.count {
            cats[position].show = false
        }
        cats[id].show = true
    }
}

extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(repository: Injector.resolve(ICatRepository.self))
    }
}
