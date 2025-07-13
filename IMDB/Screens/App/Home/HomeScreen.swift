//
//  HomeScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI
import CoreData
import FlowStacks

struct HomeScreen: View {

    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var navigator: FlowNavigator<AppCoordinator.Screen>
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
            NavigationStack {
                moviesList()
                .navigationTitle("IMDB")
            }
            .searchable(text: $viewModel.searchText, prompt: "Search movies...")
            .errorAlert(error: $viewModel.error)
    }
    
    @ViewBuilder
    func moviesList() -> some View {
        DynamicFetchView(predicate: NSPredicate(format: "query == %@", viewModel.searchText), sortDescriptors: []) { (searchs: FetchedResults<Search>) in
            List {
                if let movies = searchs.first?.movies {
                    ForEach(movies) { movie in
                        Button(action: {
                            navigator.push(.details(movie.id))
                        }, label: {
                            MovieListRow(id: movie.id)
                        })
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
                    if (searchs.first?.movies ?? []).isEmpty, !viewModel.searchText.isEmpty {
                        if viewModel.state.hasNoData {
                            Text("Oops, No results found.")
                        } else if !viewModel.state.hasError {
                            ProgressView()
                        }
                    }
                }
                )
            }
    }
}

#Preview {
    HomeScreen(viewModel: HomeViewModel(apiService: MockAPIService(), context: DataStack.preview.container.viewContext))
}
