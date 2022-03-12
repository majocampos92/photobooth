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
    
    var body: some View {
        NavigationView {
            List {
                switch viewModel.state {
                case .loaded:
                    ForEach(viewModel.sections, id: \.self) { item in
                        VStack {
                            HStack {
                                Text(item.tag != "" ? "\(item.tag)" : "All")
                                
                                Spacer()
                                
                                NavigationLink("", destination: GalleryView(tag: item.tag))
                            }
                            HStack {
                                ForEach(item.images, id: \.self) { image in
                                    KFImage(URL(string: image))
                                            .resizable()
                                            .cornerRadius(Constants.galleryImageCornerRadius)
                                            .frame(height: 120)
                                }
                            }
                        }
                    }
                case .loading:
                    ProgressView()
                case .idle:
                    Color.clear.onAppear(perform: viewModel.getSections)
                case .failed(_):
                    Text("Error!!")
                }
            }
            .navigationTitle("Cats App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: HomeViewModel = .make()
        HomeView(viewModel: viewModel)
    }
}
