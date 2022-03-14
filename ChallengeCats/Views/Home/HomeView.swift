//
//  ContentView.swift
//  ChallengeCats
//
//  Created by Jo on 4/3/22.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .make()
    
    var body: some View {
        VStack {
            /// Check the status of the request to show the type of view
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.getTags)
            case .loading:
                ProgressView()
            case .failed(_):
                Text("Error, please try again.")
                    .onTapGesture(perform: viewModel.getTags)
            case .loaded:
                List {
                    ForEach(viewModel.sections, id: \.self) { item in
                        Section(
                            header: NavigationLink(destination: GalleryView(tag: item.tag)) {
                                Text(!item.tag.isEmpty ? "\(item.tag)" : "All")
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
                            }
                        ) {
                            ScrollView(.horizontal) {
                                HStack(spacing: Constants.sectionCardSpacing) {
                                    ForEach(item.images, id: \.self) { image in
                                        KFImage(URL(string: image))
                                                .resizable()
                                                .cornerRadius(Constants.cardCornerRadius)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = .make()
        HomeView(viewModel: viewModel)
    }
}
