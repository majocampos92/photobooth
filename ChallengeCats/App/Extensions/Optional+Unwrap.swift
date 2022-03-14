//
//  Optional+Unwrap.swift
//  ChallengeCats
//
//  Created by Jo on 6/3/22.
//

import Foundation

extension Optional {
    func unwrap<T>() -> T {
        guard let type = self as? T else { fatalError("Unable to unwrap \(T.self)") }
        return type
    }
}
