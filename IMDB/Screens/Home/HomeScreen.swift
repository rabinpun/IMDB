//
//  HomeScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.updatedAt, ascending: true)],
        animation: .default)
    private var movies: FetchedResults<Movie>
    
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
            NavigationStack {
                moviesList()
                .navigationTitle("IMDB")
            }
            .searchable(text: $searchText, prompt: "Search movies...")
    }
    
    @ViewBuilder
    func moviesList() -> some View {
        List {
            ForEach(movies) { movie in
                HStack {
                    posterImage(for: movie)
                    
                    titleAndReleaseDate(for: movie)
                    
                    Spacer()
                    
                    Image.chevronRight
                }
            }
        }
        .overlay(
            movies.isEmpty ? Text("Oops, No results found.") : nil
        )
    }
    
    @ViewBuilder
    func posterImage(for movie: Movie) -> some View {
        Group {
            if let posterPath = movie.posterImagePath, let url = URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)") {
                CachedAsyncImage(url: url)
                    .aspectRatio(contentMode: .fill)
            } else {
                Image.photoPlaceHolder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 50, height: 50)
        .cornerRadius(2)
    }
    
    @ViewBuilder
    func titleAndReleaseDate(for movie: Movie) -> some View {
        VStack(alignment: .leading) {
            Text(movie.title ?? "Title unavailable")
                .font(.title2)
            Text("Released on: \(movie.releaseDate?.formattedDate ?? "Unavailable")")
        }
    }
}

#Preview {
    HomeScreen().environment(\.managedObjectContext, DataStack.preview.container.viewContext)
}
