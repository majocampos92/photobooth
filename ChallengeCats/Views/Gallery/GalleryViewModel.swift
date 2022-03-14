//
//  GalleryViewModel.swift
//  ChallengeCats
//
//  Created by Jo on 6/3/22.
//

import Foundation
import Combine

final class GalleryViewModel: ObservableObject {
    
    @Published var images: [String] = [] /// [This property is] for show image cats
    var galleryComplete = false /// [This property is] for verify that complete all images request

    private let galleryService: GalleryServiceType /// [This property is] the service for get cat data
    private var cancellable = Set<AnyCancellable>() /// [This property is] management to cancel combines
    private var currentPage = 0 /// [This property is] to identify which data page you are on for the request
    
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
    }
    
    /// Use this method to get cats images by tag
    func getImages(tag: String) {
        let params = CatParams(tags: tag, skip: currentPage, limit: Constants.galleryLimitPerPage)
        galleryService.getAll(params: params)
            .sink(receiveCompletion: { _ in }, receiveValue: { cats in
                /// Add new images to array variable
                self.images.append(contentsOf: cats.map { model in
                    model.getImageUrl()
                })
                self.currentPage += Constants.galleryLimitPerPage /// Increase the page to request
                self.galleryComplete = cats.count < Constants.galleryLimitPerPage /// Verify that obtaining images finished
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
