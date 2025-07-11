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
    private var items: FetchedResults<Movie>
    
    
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
            ForEach(items) { item in
                HStack {
                    posterImage(for: item)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(2)
                    Text(item.title ?? "No title")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
        .overlay(
            Group {
                    if items.isEmpty {
                        Text("Oops, No results found.")
                    }
                }
        )
    }
    
    @ViewBuilder
    func posterImage(for movie: Movie) -> some View {
        if let posterPath = movie.posterImagePath, let url = URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)") {
            AsyncImage(url: url)
        } else {
            Image(systemName: "photo")
                .resizable()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    HomeScreen().environment(\.managedObjectContext, DataStack.preview.container.viewContext)
}
