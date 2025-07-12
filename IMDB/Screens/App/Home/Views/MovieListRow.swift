//
//  MovieListRow.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

struct MovieListRow: View {
    
   let movie: Movie
    
    var body: some View {
        HStack {
            posterImage(for: movie)
            
            titleAndReleaseDate(for: movie)
            
            Spacer()
            
            Image.chevronRight
        }
    }
    
    @ViewBuilder
    func posterImage(for movie: Movie) -> some View {
        Group {
            if let posterPath = movie.posterImagePath, let url = URL(string: posterPath.thumbnailImagePath) {
                CachedAsyncImage(url: url)
                    .aspectRatio(contentMode: .fill)
            } else {
                Image.photoPlaceHolder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 50, height: 50)
        .cornerRadius(5)
    }
    
    @ViewBuilder
    func titleAndReleaseDate(for movie: Movie) -> some View {
        VStack(alignment: .leading) {
            Text(movie.title ?? "Title unavailable")
                .font(.title2)
                .lineLimit(2)
            Text("Released on: \(movie.releaseDate?.formattedDate ?? "Unavailable")")
        }
    }
}

#Preview {
    MovieListRow(movie: Movie.dummyMovie)
}
