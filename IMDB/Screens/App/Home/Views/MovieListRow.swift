//
//  MovieListRow.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

struct MovieListRow: View {
    
    let id: Int32
    @Environment(\.managedObjectContext) var context
    @FetchRequest
    var movies: FetchedResults<Movie>
    
    var movie: Movie? {
        movies.first
    }
    
    init(id: Int32) {
        self.id = id
        _movies = FetchRequest<Movie>(sortDescriptors: [], predicate: NSPredicate(format: "id == %d", id))
    }
    
    var body: some View {
        HStack {
            posterImage(for: movie)
            
            titleAndReleaseDate(for: movie)
            
            Spacer()
            
            StarButton(isFavorite: movie?.isFavorite) {
                toggleFavorite()
            }
        }
    }
    
    @ViewBuilder
    func posterImage(for movie: Movie?) -> some View {
        Group {
            if let posterPath = movie?.posterImagePath, let url = URL(string: posterPath.thumbnailImagePath) {
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
    func titleAndReleaseDate(for movie: Movie?) -> some View {
        VStack(alignment: .leading) {
            Text(movie?.title ?? "Title unavailable")
                .font(.title2)
                .lineLimit(2)
                .foregroundColor(.primary)
            
            Text("Released on: \(movie?.releaseDate?.formattedDate ?? "Unavailable")")
                .foregroundColor(.secondary)
        }
    }
    
    func toggleFavorite() {
        movie?.isFavorite.toggle()
        try? context.save()
    }
}

#Preview {
    MovieListRow(id: 1)
        .environment(\.managedObjectContext, DataStack.preview.container.viewContext)
}
