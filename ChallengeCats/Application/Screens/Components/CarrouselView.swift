//
//  CarrouselView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 5/3/22.
//

import Foundation
import SwiftUI

struct CarrouselView: View {
    let models: [Cat]
    let viewModel: HomeViewModel
    @State var pointX: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 250
    @State public var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(models, id: \.self) { item in
                CardView(model: item)
                    .offset(x: self.pointX)
                    .highPriorityGesture(DragGesture()
                        .onChanged({ value in
                        if value.translation.width > 0 {
                            self.pointX = value.location.x
                        } else {
                            self.pointX = value.location.x - self.screen
                        }
                    }).onEnded({ value in
                        if value.translation.width > 0 {
                            if value.translation.width > ((screen - 100 ) / 2 )
                                && Int(self.count) != viewModel.getMid() {
                                self.count += 1
                                viewModel.updateHeigth(value: Int(self.count))
                                self.pointX = (self.screen + 5) * self.count
                            } else {
                                self.pointX = (self.screen + 5) * self.count
                            }
                        } else {
                            if -value.translation.width > ((screen - 100 ) / 2 )
                                    && -Int(self.count) != viewModel.getMid() {
                                self.count -= 1
                                viewModel.updateHeigth(value: Int(self.count))
                                self.pointX = (self.screen + 5) * self.count
                            } else {
                                self.pointX = (self.screen + 5) * self.count
                            }
                        }

                    })
                )
            }
        }
        .shadow(color: .gray.opacity(0.5), radius: 15, x: 10, y: 10)
    }
}
