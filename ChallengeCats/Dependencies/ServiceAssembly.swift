//
//  RepositoryAssembly.swift
//  ChallengeCats
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
        container.register(GalleryServiceType.self) { resolver in
            GalleryNetworkService(provider: resolver~>)
        }
    }
}
