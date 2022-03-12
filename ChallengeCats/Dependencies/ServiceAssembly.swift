//
//  RepositoryAssembly.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Swinject
import SwinjectAutoregistration
import Moya

public struct ServiceAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(MoyaProvider<GalleryAPI>.self) { _ in
            MoyaProvider<GalleryAPI>()
        }
        container.register(GalleryNetworkService.self) { resolver in
            GalleryNetworkService(provider: resolver~>)
        }
        container.register(GalleryServiceType.self) { resolver in
            GalleryService(service: resolver~>)
        }
    }
}
