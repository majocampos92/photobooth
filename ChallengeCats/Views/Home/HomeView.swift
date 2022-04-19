//
//  ContentView.swift
//  ChallengeCats
//
//  Created by Jo on 4/3/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    
    var body: some View {
        VStack {
            if viewModel.showEmptyState {
                emptyState
            } else {
                sections
            }
        }
    }
    
    var sections: some View {
        List {
            SkeletonForEach(with: viewModel.sections, quantity: Constants.homeLimitPerPage) { loading, model in
                let tag = model?.tag ?? Constants.empty
                Section(
                    header: NavigationLink(destination: GalleryView(tag: tag)) {
                        Text(!tag.isEmpty ? "\(tag)" : "All")
                            .font(.system(.title3))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 7)
                             .foregroundColor(.primary)
                             .padding()
                    } .skeleton(with: loading)
                ) {
                    ScrollView(.horizontal) {
                        HStack(spacing: Constants.sectionCardSpacing) {
                            SkeletonForEach(with: model?.images ?? [], quantity: Constants.homeLimitPerPage) { photoLoading, item in
                                let imageUrl = URL(string: item?.path ?? Constants.empty)
                                KFImage(imageUrl)
                                        .resizable()
                                        .cornerRadius(Constants.cardCornerRadius)
                                        .skeleton(with: photoLoading)
                                        .shape(type: .rectangle)
                                        .frame(width: 128, height: 104)
                            }
                        }
                    }
                }
            }
            .listRowInsets(
                EdgeInsets(
                    top: Constants.sectionCardSpacing,
                    leading: Constants.sectionCardSpacing,
                    bottom: 0, trailing: 0
                )
            )
            .listRowSeparator(.hidden)
            
            /// Verify that the tags variable still has values to show the loading when making the next request
            if !viewModel.tags.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                        .onAppear {
                            viewModel.getSections()
                        }
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .navigationBarTitle("Cats App", displayMode: .inline)
        .listStyle(PlainListStyle())
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = .make()
        HomeView(viewModel: viewModel)
    }
}
