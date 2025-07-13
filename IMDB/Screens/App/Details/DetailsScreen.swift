//
//  DetailsScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

struct DetailsScreen: View {
    
    let id: Int32
    @Environment(\.managedObjectContext) var context
    @FetchRequest
    var movies: FetchedResults<Movie>
    @State var error: AppError?
    
    var movie: Movie? {
        movies.first
    }
    
    init(id: Int32) {
        self.id = id
        _movies = FetchRequest<Movie>(sortDescriptors: [], predicate: NSPredicate(format: "id == %d", id))
    }
    
    var body: some View {
        ScrollView {
           VStack(alignment: .leading, spacing: 16) {

               // Poster
               posterImage()
               
               // Title
               Text(movie?.title ?? "")
                   .font(.title)
                   .fontWeight(.bold)

               // Release Date
               Text("Release Date: \(movie?.releaseDate?.toFormattedString ?? "Unavailable")")
                   .font(.subheadline)
                   .foregroundColor(.secondary)

               // Overview
               Text(movie?.overview ?? "")
                   .font(.body)
                   .multilineTextAlignment(.leading)

               Spacer()
           }
           .padding()
           }
           .navigationTitle("Movie Details")
           .navigationBarTitleDisplayMode(.inline)
           .navigationBarBackButtonHidden()
           .toolbar(content: {
               ToolbarItem(placement: .topBarTrailing) {
                   StarButton(isFavorite: movie?.isFavorite) {
                       toggleFavorite()
                   }
               }
               
               ToolbarItem(placement: .topBarLeading) {
                   BackButton()
               }
           })
           .errorAlert(error: $error)
    }
    
    @ViewBuilder
    func posterImage() -> some View {
        Group {
            if let posterPath = movie?.posterImagePath, let url = URL(string: posterPath.originalImagePath) {
                CachedAsyncImage(url: url)
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
            }
        }
    }
    
    func toggleFavorite() {
        do {
            movie?.isFavorite.toggle()
            try context.save()
        } catch {
            self.error = AppError(message: "Failed to save. Try again.")
        }
    }
}

#Preview {
    NavigationStack {
        DetailsScreen(id: 2)
            .environment(\.managedObjectContext, DataStack.preview.container.viewContext)
    }
}
