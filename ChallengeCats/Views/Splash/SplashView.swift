//
//  SplashView.swift
//  ChallengeCats
//
//  Created by Jo on 14/3/22.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Image("catrainbow")
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 150, height: 150)
                     .cornerRadius(100)
                
                Text("Your Cats App")
                    .font(.system(.title3))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                Text("Photobooth")
                    .foregroundColor(.primary)
                Text("Take Home Assesment")
                    .foregroundColor(.primary)
                NavigationLink(destination: HomeView()) {
                    Text("Tap me")
                        .font(.system(.title3))
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 20, leading: 80, bottom: 20, trailing: 80))
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
        }
    }
}
