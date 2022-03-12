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
    var galleryComplete = false

    private let galleryService: GalleryServiceType
    private var cancellable = Set<AnyCancellable>()
    private var currentPage = 0
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    func getImages(tag: String) {
        let params = CatParams(tags: tag, skip: currentPage, limit: Constants.galleryLimitPerPage)
        galleryService.getAll(params: params)
            .sink(receiveCompletion: { _ in }, receiveValue: { cats in
                self.images.append(contentsOf: cats.map { model in
                    model.getImageUrl()
                })
                self.currentPage += Constants.galleryLimitPerPage
                self.galleryComplete = cats.count < Constants.galleryLimitPerPage
            }
        )
        .store(in: &cancellable)
    }
}

extension GalleryViewModel {
    static func make() -> GalleryViewModel {
        GalleryViewModel(galleryServiceType: Injector.resolve(GalleryServiceType.self))
    }
}
