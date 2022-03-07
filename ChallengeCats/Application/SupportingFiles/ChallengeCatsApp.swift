//
//  ChallengeCatsApp.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 4/3/22.
//

import SwiftUI

@main
struct ChallengeCatsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .make())
        }
    }
}
