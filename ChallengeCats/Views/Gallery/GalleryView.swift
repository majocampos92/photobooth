//
//  GaleryView.swift
//  ChallengeCats
//
//  Created by Jo on 4/3/22.
//

import SwiftUI
import Kingfisher

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel = .make()
    let tag: String
    
    var body: some View {
        /// Create grid columns
        let columns = Array(
            repeating: GridItem(
                .flexible(),
                spacing: Constants.galleryCardSpacing
            ),
            count: Constants.galleryGridColumns
        )
        GeometryReader { geometry in
            /// Calculate image size 
            let size = geometry.size.width / CGFloat(Constants.galleryGridColumns) - Constants.galleryCardSpacing
            List {
                LazyVGrid(columns: columns, spacing: Constants.galleryCardSpacing) {
                    ForEach(viewModel.images, id: \.self) { image in
                        KFImage(URL(string: image))
                            .resizable()
                            .frame(width: size, height: size)
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                
                /// Verify that the request for all images has not finished to show the load element
                if !viewModel.galleryComplete {
                    HStack {
                        Spacer()
                        ProgressView()
                            .onAppear {
                                viewModel.getImages(tag: tag)
                            }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationBarTitle(!tag.isEmpty ? "\(tag)" : "All", displayMode: .inline)
            .listStyle(PlainListStyle())
        }
    }
}
