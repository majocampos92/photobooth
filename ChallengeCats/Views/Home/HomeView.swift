//
//  ContentView.swift
//  ChallengeCats
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    
    var body: some View {
        if viewModel.showEmptyState {
            emptyState
        } else {
            sections
        }
    }
    
    var sections: some View {
        List {
            SkeletonForEach(with: viewModel.sections, quantity: Constants.homeLimitPerPage) { loading, model in
                let tag = model?.tag ?? Constants.empty
                Section(
                    header: NavigationLink(destination: GalleryView(tag: tag)) {
                        Text(!tag.isEmpty ? tag : L10n.all)
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
                    }.skeleton(with: loading)
                ) {
                    ScrollView(.horizontal) {
                        HStack(spacing: Constants.homeSectionCardSpacing) {
                            SkeletonForEach(with: model?.photos ?? [], quantity: Constants.homeLimitPerPage) { photoLoading, item in
                                let imageUrl = URL(string: item?.path ?? Constants.empty)
                                KFImage(imageUrl)
                                        .resizable()
                                        .cornerRadius(Constants.homeCardCornerRadius)
                                        .skeleton(with: photoLoading)
                                        .shape(type: .rounded(.radius(Constants.homeCardCornerRadius)))
                                        .frame(width: Constants.homeImageSize, height: Constants.homeImageSize)
                            }
                        }
                    }
                }
            }
            .listRowInsets(
                EdgeInsets(
                    top: Constants.homeSectionCardSpacing,
                    leading: Constants.homeSectionCardSpacing,
                    bottom: CGFloat(Constants.zero),
                    trailing: CGFloat(Constants.zero)
                )
            )
            .listRowSeparator(.hidden)
            
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
        .navigationBarTitle(L10n.appName, displayMode: .inline)
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
