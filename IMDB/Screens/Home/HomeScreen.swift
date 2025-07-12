//
//  HomeScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI
import CoreData

struct HomeScreen: View {

    @StateObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
            NavigationStack {
                moviesList()
                .navigationTitle("IMDB")
            }
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
    }
    
    @ViewBuilder
    func moviesList() -> some View {
        DynamicFetchView(predicate: NSPredicate(format: "query == %@", viewModel.searchText), sortDescriptors: []) { (searchs: FetchedResults<Search>) in
            List {
                if let movies = searchs.first?.movies {
                    ForEach(movies) { movie in
                       MovieListRow(movie: movie)
                        .task {
                            if viewModel.hasReachedToBottom(movies: movies, movie: movie) {
                                await viewModel.fetchNextPage()
                            }
                        }
                    }
                }
            }
            .overlay(
                Group {
                    if (searchs.first?.movies ?? []).isEmpty {
                        if viewModel.state.noData {
                            Text("Oops, No results found.")
                        } else if !viewModel.searchText.isEmpty {
                            ProgressView()
                        }
                    }
                }
                )
            }
    }
}

#Preview {
    HomeScreen(viewModel: HomeViewModel(context: DataStack.preview.container.viewContext))
}
