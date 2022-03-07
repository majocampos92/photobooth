//
//  CardView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct CardView: View {
    let model: Cat
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.zero) {
            KFImage(model.url)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width / 2,
                    height: model.show ? UIScreen.main.bounds.height / 3.5  : UIScreen.main.bounds.height / 4.5
                )
        }
        .cornerRadius(Constants.cardCornerRadius)
    }
}
