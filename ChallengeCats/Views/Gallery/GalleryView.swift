//
//  GaleryView.swift
//  ChallengeCats
//
//  Created by Maria Jose Campos on 4/3/22.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel = .make()
    let tag: String
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(
                .flexible(),
                spacing: Constants.galleryCardSpacing
            ),
            count: Constants.galleryGridColumns
        )
        ScrollView {
            switch viewModel.state {
            case .loaded:
                LazyVGrid(columns: columns, spacing: Constants.galleryCardSpacing) {
                    ForEach(viewModel.images, id: \.self) { image in
                        KFImage(URL(string: image))
                            .resizable()
                            .cornerRadius(Constants.galleryImageCornerRadius)
                            .frame(width: 120, height: 120)
                    }
                }
                .padding(.all)
            case .loading:
                ProgressView()
            case .idle:
                Color.clear.onAppear(perform: {viewModel.getImages(tag: tag)})
            case .failed(_):
                Text("Error!!")
            }
        }
        .navigationBarTitle(tag != "" ? "\(tag)" : "All", displayMode: .inline)
    }
}
