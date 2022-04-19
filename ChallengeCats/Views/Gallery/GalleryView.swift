//
//  GaleryView.swift
//  ChallengeCats
//
//  Created by Jo on 4/3/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct GalleryView: View {
    @StateObject var viewModel: GalleryViewModel = .make()
    let tag: String
    
    private let columns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: Constants.galleryCardSpacing),
        count: Constants.galleryGridColumns
    )
    
    var body: some View {
        VStack {
            if viewModel.showEmptyState {
                emptyState
            } else {
                photos
            }
        }
        .navigationBarTitle(L10n.appName, displayMode: .inline)
    }
    
    var photos: some View {
        GeometryReader { geometry in
        /// Calculate image size
        let size = geometry.size.width / CGFloat(Constants.galleryGridColumns) - Constants.galleryCardSpacing
            List {
                LazyVGrid(columns: columns, spacing: Constants.galleryCardSpacing) {
                    SkeletonForEach(with: viewModel.photos, quantity: Constants.galleryLimitPerPage) { loading, photo in
                        let imageUrl = URL(string: photo?.path ?? Constants.empty)
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFill()
                            .skeleton(with: loading)
                            .shape(type: .rectangle)
                            .frame(width: size, height: size)
                            .clipped()
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                if !viewModel.galleryComplete {
                    HStack {
                        Spacer()
                        ProgressView()
                            .onAppear {
                                viewModel.getPhotos(tag: tag)
                            }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var emptyState: some View {
        VStack {
            Spacer()
            Text(L10n.emptyState)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
