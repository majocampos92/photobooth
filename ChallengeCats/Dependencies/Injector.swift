//
//  Injector.swift
//  ChallengeCats
//
//  Created by Jo on 6/3/22.
//

import Swinject

enum Injector {
    static let current: Assembler = {
        let container = Container()
        let assambler = Assembler(
            [
                ServiceAssembly()
            ],
            container: container
        )
        return assambler
    }()
}

extension Injector {
    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        let service: Service = current.resolver.resolve(serviceType).unwrap()
        return service
    }
}
