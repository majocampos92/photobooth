//
//  GalleryViewModel.swift
//  ChallengeCats
//

import Foundation
import Combine

final class GalleryViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [] /// [This property is] for show image cats
    @Published private(set) var showEmptyState = false /// [This property is] for show or hide empty state
    var galleryComplete = true /// [This property is] for verify that complete all images request

    private let galleryService: GalleryServiceType /// [This property is] the service for get cat data
    private var cancellable = Set<AnyCancellable>() /// [This property is] management to cancel combines
    private var currentPage = Constants.zero /// [This property is] to identify which data page you are on for the request
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    /// Use this method to get cats images by tag
    func getPhotos(tag: String) {
        let params = CatParams(tags: tag, skip: currentPage, limit: Constants.galleryLimitPerPage)
        galleryService.getAll(params: params)
            .sink(receiveCompletion: { _ in }, receiveValue: { cats in
                self.photos.append(contentsOf: cats.map { model in
                    Photo(path: model.getImageUrl())
                })
                self.currentPage += Constants.galleryLimitPerPage
                self.galleryComplete = cats.count < Constants.galleryLimitPerPage /// Verify that obtaining images finished
                self.showEmptyState = self.photos.isEmpty
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
