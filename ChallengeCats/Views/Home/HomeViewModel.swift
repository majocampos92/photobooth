//
//  ViewModel.swift
//  ChallengeCats
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var sections: [SectionModel] = [] /// [This property is] for show cats by tag
    @Published private(set) var showEmptyState = false
    
    private let galleryService: GalleryServiceType /// [This property is] the service for get cat data
    private var cancellable = Set<AnyCancellable>() /// [This property is] management to cancel combines
    private var currentPage = Constants.zero /// [This property is] to identify which data page you are on for the request
    private(set) var tags: [String] = [] /// [This property is] the cat tags
   
    init(galleryServiceType: GalleryServiceType) {
        galleryService = galleryServiceType
        getTags()
    }
    
    /// Use this method to generate sections cats by tag with pagination
    func getSections() {
        /// Check the available tags to obtain the data limit to request 
        let limit = tags.count > Constants.homeLimitPerPage ? Constants.homeLimitPerPage : tags.count - 1
        let range = Constants.zero...limit /// Range of requests to perform
        (range).forEach { index in
            getCats(tag: tags[index]) /// Invoke function to get cats by current loop tag
        }
        tags.removeSubrange(range) /// Remove requested tags
        currentPage += Constants.homeLimitPerPage
    }
    
    /// Use this method to get cat tags
    private func getTags() {
        galleryService.getTags()
            .sink(receiveCompletion: { _ in },
             receiveValue: { items in
                self.showEmptyState = items.isEmpty
                if !items.isEmpty {
                    self.tags = items
                    self.getSections()
                }
            }
        )
        .store(in: &cancellable)
    }
    
    /// Use this method to get cats by tag
     private func getCats(tag: String) {
         galleryService.getAll(params: CatParams(tags: tag, limit: Constants.homeLimitPerPage))
             .sink(receiveCompletion: { _ in }, receiveValue: { cats in
                 if !cats.isEmpty {
                     /// Create new array with the cat image url
                     let images = cats.map { model in
                         Photo(path: model.getImageUrl())
                     }
                     self.sections.append(SectionModel(tag: tag, photos: images)) /// Add new section to array variable
                 }
                 self.showEmptyState = self.sections.isEmpty
             }
         )
         .store(in: &cancellable)
     }
}

extension HomeViewModel {
    static func make() -> HomeViewModel {
        HomeViewModel(galleryServiceType: Injector.resolve(GalleryServiceType.self))
    }
}
