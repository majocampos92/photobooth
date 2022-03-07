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
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(
                .flexible(),
                spacing: Constants.galleryCardSpacing
            ),
            count: Constants.galleryGridColumns
        )
        ScrollView {
            ScrollView(.horizontal) {
                VStack {
                    HStack(spacing: 20) {
                        ForEach(viewModel.tags, id: \.self) { tag in
                            ChipView(name: tag)
                                .onTapGesture {
                                    viewModel.addTag(tag: tag)
                                }
                        }
                    }
                }
                .padding()
            }
            switch viewModel.state {
            case .loaded:
                LazyVGrid(columns: columns, spacing: Constants.galleryCardSpacing) {
                    ForEach(viewModel.cats, id: \.self) { item in
                        KFImage(item.url)
                            .resizable()
                            .cornerRadius(Constants.galleryImageCornerRadius)
                            .frame(width: 120, height: 120)
                    }
                }
                .padding(.all)
            case .loading:
                ProgressView()
            case .idle:
                Color.clear.onAppear(perform: viewModel.getCatTags)
            case .failed(_):
                Text("Error!!")
            }
        }
        .navigationTitle("Gallery")        
    }
}
