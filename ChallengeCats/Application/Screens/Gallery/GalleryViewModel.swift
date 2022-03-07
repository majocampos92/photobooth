//
//  GalleryViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

final class GalleryViewModel: CatViewModel {
    @Published var tags: [String] = []
    var tagSelected: [String] = []
    
    override init(repository: ICatRepository) {
        super.init(repository: repository)
        getCats(query: "")
        getCatTags()
    }
    
    func getCatTags() {
        catRepository.getTags()?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    print("Error \(failure)")
                case .finished:
                   print("Success!!")
                }
            }, receiveValue: { response in
                self.tags = response
            }
        )
        .store(in: &disposables)
    }
    
    func addTag(tag: String) {
        
        if tagSelected.contains(tag) {
            guard let index = tagSelected.firstIndex(of: tag) else { return }
            tagSelected.remove(at: index)
        } else {
            tagSelected.append(tag)
        }
        getCats(query: "tags=\(tagSelected.joined(separator: ","))")
    }
}

extension GalleryViewModel {
    static func make() -> GalleryViewModel {
        GalleryViewModel(repository: Injector.resolve(ICatRepository.self))
    }
}
