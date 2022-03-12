//
//  ViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var sections: [SectionModel] = []
    @Published private(set) var state = State.idle
    
    private let galleryService: GalleryServiceType
    private var cancellable = Set<AnyCancellable>()
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    func getSections() {
        state = .loading
        Publishers.Zip(galleryService.getTags(), galleryService.getAll(params: CatParams()))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.state = .failed(failure)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { [weak self] tags, cats in
                tags.forEach { tag in
                    let images = cats.filter({ $0.tags.contains(tag) }).map { model in
                        "\(Constants.baseUrl)cat/\(model.id)"
                    }.prefix(3)
                                       
                    if images.count > 0 {
                        self?.sections.append(SectionModel(tag: tag, images: Array(images)))
                    }
                }
            }
        )
            .store(in: &cancellable)
    }
}

extension HomeViewModel {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
}

extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(galleryServiceType: Injector.resolve(GalleryServiceType.self))
    }
}
