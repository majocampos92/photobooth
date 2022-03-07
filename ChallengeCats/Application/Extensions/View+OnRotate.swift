//
//  View+OnRotate.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 6/3/22.
//

import Foundation
import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
