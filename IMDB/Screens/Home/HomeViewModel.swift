//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation
import Combine
import CoreData

class HomeViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    @Published var state: State = .initial
    @Published var searchText = ""
    @Published var error: Error?
    
    let context: NSManagedObjectContext
    let apiService: APIService
    
    init(apiService: APIService = IAPIService(), context: NSManagedObjectContext) {
        self.apiService = apiService
        self.context = context
        
        /// observe the events like searchText update
        observeEvents()
    }
    
    private func observeEvents() {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main) // Debounce of 1 sec so to reduce the excessive network call on each character change
            .sink(receiveValue: { [weak self] searchText in
                Task {
                    await self?.searchMovies(searchText: searchText,refresh: true) // refresh true to refresh the movies list is fetched from page 1
                }
            })
            .store(in: &cancellables)
    }
    
    /// Call the search movie api
    /// - Parameter searchText: search query text
    /// - Parameter refresh: force refresh the fetch
    func searchMovies(searchText: String, refresh: Bool = false) async {
        guard !searchText.isEmpty, !state.isFetching, (state.canFetchNextPage || refresh) else { return }
        let nextPageNumber = refresh ? "1" : state.nextPageNumber
        await MainActor.run {
            self.state = .fetching
        }
        do {
            let searchMoviesResponse: SearchMoviesResponse = try await apiService.fetch(APIRequest(endPoint: .search, parameters: SearchMovieParameter(query: searchText, page: nextPageNumber)))
            await MainActor.run {
                self.state = .data(searchMoviesResponse)
                self.addMoviesToDB(moviesResponse: searchMoviesResponse.results, refresh: refresh)
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
    
    func fetchNextPage() async {
        await searchMovies(searchText: searchText, refresh: false) // refresh false to maintain the pagination
    }
    
    /// Add movies to the data base
    /// - Parameters:
    ///   - moviesResponse: List of movie response from api
    ///   - refresh:If true resets the movies to this list instead of adding to previous list
    func addMoviesToDB(moviesResponse: [MovieResponse], refresh: Bool) {
        let movies = moviesResponse.map { movieResponse in
            let movie: Movie = findOrCreateItem(predicate: NSPredicate(format: "id == %d", movieResponse.id))
            movie.update(with: movieResponse)
            return movie
        }
        
        let search: Search = findOrCreateItem(predicate: NSPredicate(format: "query == %@", searchText))
        search.query = searchText
        
        // Set the movies to the search entity if refresh reset the movies else update the existing list
        if refresh {
            search.setMovies(movies)
        } else {
            search.addMovies(movies)
        }
        
        try? context.save()
    }
    
    /// Finds and return an entity if not found creates a new entity
    /// - Parameter predicate: Perdicate to search the entity
    /// - Returns: Returns a found or newly created entity
    func findOrCreateItem<Entity: Fetchable & Creatable>(predicate: NSPredicate) -> Entity where Entity.Item == Entity {
        let fetchRequest = Entity.fetch()
        fetchRequest.predicate = predicate
        guard let entity: Entity = try? context.fetch(fetchRequest).first else {
            return Entity.create(context: context)
        }
        return entity
    }
    
    /// Check if the movie is on the bottom section of the loaded movies
    /// - Parameters:
    ///   - movies: Movies list
    ///   - movie: Current movie
    /// - Returns: Returs if the movie is at the bottom section of the movie list
    func hasReachedToBottom(movies: [Movie], movie: Movie) -> Bool {
        guard movies.count >= APIEndpoint.paginationSize else { return false }
        let fetchThreshold = 7 // 7 so that the user doesnt need to scroll to the very bottom to load next page
        return movies[movies.count - fetchThreshold..<movies.count].map({ $0.id }).contains(movie.id)
    }
    
}
