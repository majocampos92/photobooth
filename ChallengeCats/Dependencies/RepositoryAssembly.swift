//
//  RepositoryAssembly.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Swinject
import SwinjectAutoregistration

public struct RepositoryAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.autoregister(ICatRepository.self, initializer: CatRepository.init)
    }
}
