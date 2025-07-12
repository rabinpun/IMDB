//
//  DetailsScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

struct DetailsScreen: View {
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
               VStack(alignment: .leading, spacing: 16) {

                   // Poster
                   posterImage()
                   
                   // Title
                   Text(movie.title ?? "")
                       .font(.title)
                       .fontWeight(.bold)

                   // Release Date
                   Text("Release Date: \(movie.releaseDate!.formattedDate)")
                       .font(.subheadline)
                       .foregroundColor(.secondary)

                   // Overview
                   Text(movie.overview ?? "")
                       .font(.body)
                       .multilineTextAlignment(.leading)

                   Spacer()
               }
               .padding()
           }
           .navigationTitle("Movie Details")
           .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func posterImage() -> some View {
        Group {
            if let posterPath = movie.posterImagePath, let url = URL(string: posterPath.originalImagePath) {
                CachedAsyncImage(url: url)
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    DetailsScreen(movie: .dummyMovie)
}
