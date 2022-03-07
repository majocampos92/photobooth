//
//  HeaderView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct HeaderView: View {
    let image: URL?
    var body: some View {
        VStack {
            KFImage(image)
                .resizable()
                .opacity(Constants.headerOpacity)
                .ignoresSafeArea(.all)
                .overlay(alignment: .top) {
                    VStack {
                        Text("Watch Cats")
                            .font(.system(size: Constants.headerFontSize, design: .default))
                            .bold()

                        Text("Explore our gallery")
                            .font(.title2)
                    }
                }
        }
        .shadow(
            color: .black,
            radius: Constants.headerRadiusShadow,
            x: Constants.zero,
            y: Constants.zero
        )
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [.white, .black]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
