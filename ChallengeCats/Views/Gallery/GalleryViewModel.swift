//
//  GalleryViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

final class GalleryViewModel: ObservableObject {
    
    @Published var images: [String] = []
    @Published private(set) var state = State.idle
    
    private let galleryService: GalleryServiceType
    private var cancellable = Set<AnyCancellable>()
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    func getImages(tag: String) {
        galleryService.getAll(params: CatParams(tags: tag))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.state = .failed(failure)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { cats in
                self.images = cats.map { model in
                    "\(Constants.baseUrl)cat/\(model.id)"
                }
            }
        )
            .store(in: &cancellable)
    }
}

extension GalleryViewModel {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
}

extension GalleryViewModel {
    static func make() -> GalleryViewModel {
        GalleryViewModel(galleryServiceType: Injector.resolve(GalleryServiceType.self))
    }
}
