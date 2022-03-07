//
//  ContentView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 4/3/22.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    @State public var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
               VStack {
                   HeaderView(image: viewModel.cat)
                       .frame(
                            width: reader.size.width,
                            height: orientation.isPortrait ? ((reader.size.height)) : ((reader.size.height) / 2)
                       )
                   Spacer()
                   VStack {
                       HStack(alignment: .center, spacing: reader.size.width / 2) {
                            Text("Cats")
                                .font(.largeTitle)
                                .bold()
                           NavigationLink("See all", destination: GalleryView())
                        }
                       CarrouselView(models: viewModel.cats, viewModel: viewModel)
                    }
                    .animation(.spring())
                    .frame(
                        width: reader.size.width,
                        height: (reader.size.height / 2)
                    )
                   Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = .make()
        HomeView(viewModel: viewModel)
.previewInterfaceOrientation(.portrait)
    }
}
