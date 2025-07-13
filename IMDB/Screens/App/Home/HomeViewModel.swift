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
    @Published var error: AppError?
    @Published var pagination: Pagination = .init(page: 0, totalPages: 0)
    
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
                if NetworkMonitor.shared.isConnected() {
                    Task {
                        await self?.searchMovies(searchText: searchText,refresh: true) // refresh true to refresh the movies list is fetched from page 1
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    /// Call the search movie api
    /// - Parameter searchText: search query text
    /// - Parameter refresh: force refresh the fetch
    func searchMovies(searchText: String, refresh: Bool = false) async {
        guard !searchText.isEmpty, !state.isFetching, (pagination.canFetchNextPage || refresh) else { return }
       
        await MainActor.run {
            if refresh {
                pagination = .init(page: 0, totalPages: 1)
            }
            state = .fetching
        }
        do {
            let searchMoviesResponse: SearchMoviesResponse = try await apiService.fetch(APIRequest(endPoint: .search, parameters: SearchMovieParameter(query: searchText, page: pagination.nextPage)))
            await MainActor.run {
                self.state = .data(searchMoviesResponse)
                self.pagination = .init(page: searchMoviesResponse.page, totalPages: searchMoviesResponse.total_pages)
                self.addMoviesToDB(moviesResponse: searchMoviesResponse.results, refresh: refresh)
            }
        } catch (let error) {
            await MainActor.run {
                let appError = AppError(message: error.localizedDescription)
                self.state = .error(appError)
                
                // ignore the no internet connection error
                guard let urlError = error as? URLError, urlError.code != .notConnectedToInternet  else { return }
                
                // ignore the cancelled error
                guard (error as NSError).code != -999  else { return }
                self.error = appError
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
        
        if refresh {
            // deleting the old search entity
            let searchFetchRequest = Search.getFetchRequest()
            searchFetchRequest.predicate = NSPredicate(format: "query == %@", searchText)
            if let search: Search = try? context.fetch(searchFetchRequest).first {
                context.delete(search)
                try? context.save()
            }
        }
        
        // creating find or create new search enity if not present
        let search: Search = findOrCreateItem(predicate: NSPredicate(format: "query == %@", searchText))
        search.query = searchText
        
        let movies = moviesResponse.map { movieResponse in
            // create movie entity
            let movie: Movie = findOrCreateItem(predicate: NSPredicate(format: "id == %d", movieResponse.id))
            movie.update(with: movieResponse)
            
            // create sort order entity
            let sortOrder: SortOrder = findOrCreateItem(predicate: NSPredicate(format: "sortOrderToMovie.id == %d && sortOrderToSearch.query == %@", movie.id, searchText))
            sortOrder.order = Date()
            sortOrder.sortOrderToMovie = movie // set movie
            sortOrder.sortOrderToSearch = search // set search

            return movie
        }
        
        // set movies to search
        search.addMovies(movies)
        
        try? context.save()
    }
    
    /// Finds and return an entity if not found creates a new entity
    /// - Parameter predicate: Perdicate to search the entity
    /// - Returns: Returns a found or newly created entity
    func findOrCreateItem<Entity: Fetchable & Creatable>(predicate: NSPredicate) -> Entity where Entity.Item == Entity {
        let fetchRequest = Entity.getFetchRequest()
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
        guard movies.count >= Pagination.size else { return false }
        let fetchThreshold = 7 // 7 so that the user doesnt need to scroll to the very bottom to load next page
        return movies[movies.count - fetchThreshold..<movies.count].map({ $0.id }).contains(movie.id)
    }
    
}
