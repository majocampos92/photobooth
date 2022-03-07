//
//  ChipView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 7/3/22.
//

import SwiftUI

struct ChipView: View {
    let name: String
    var body: some View {
        Text(name)
            .fontWeight(.semibold)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Capsule().stroke(Color.black, lineWidth: 1))
            .lineLimit(1)
    }
}
