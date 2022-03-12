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
    private(set) var tags: [String] = []
    private var currentPage = 0
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    func getTags() {
        state = .loading
        galleryService.getTags()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let failure):
                    self.state = .failed(failure)
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { items in
                self.tags = items
                self.getSections()
            }
        )
        .store(in: &cancellable)
    }
    
    func getSections() {
        let limit = tags.count > Constants.homeLimitPerPage ? Constants.homeLimitPerPage : tags.count - 1
        let range = Constants.zero...limit
        (range).forEach { index in
            getCats(tag: tags[index])
        }
        tags.removeSubrange(range)
        currentPage += Constants.homeLimitPerPage
    }
    
    private func getCats(tag: String) {
        galleryService.getAll(params: CatParams(tags: tag, limit: Constants.homeLimitPerPage))
            .sink(receiveCompletion: { _ in }, receiveValue: { cats in
                if cats.count > 0 {
                    let images = cats.map { model in
                        model.getImageUrl()
                    }
                    self.sections.append(SectionModel(tag: tag, images: images))
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
