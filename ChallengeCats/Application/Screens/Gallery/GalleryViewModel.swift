//
//  GalleryViewModel.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import Combine

final class GalleryViewModel: CatViewModel {
    
    override init(repository: ICatRepository) {
        super.init(repository: repository)
        getCats(query: "")
    }
    
}

extension GalleryViewModel {
    static func make() -> GalleryViewModel {
        GalleryViewModel(repository: Injector.resolve(ICatRepository.self))
    }
}
