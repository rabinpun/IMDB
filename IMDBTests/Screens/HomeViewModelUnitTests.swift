//
//  HomeViewModelUnitTests.swift
//  IMDBTests
//
//  Created by Rabin Pun on 13/07/2025.
//

import XCTest
import CoreData
@testable import IMDB

final class HomeViewModelUnitTests: XCTestCase {
    
    let searchQuery = "xyz"
    var apiService: MockAPIService!
    var context: NSManagedObjectContext!
    var sut : HomeViewModel!
    let moviesArrayOne = Array(MovieResponse.dummyMovies[0..<3])
    let moviesArrayTwo = Array(MovieResponse.dummyMovies[3..<MovieResponse.dummyMovies.count])

    override func setUpWithError() throws {
        apiService = MockAPIService()
        context = DataStack(inMemory: true).container.viewContext
        sut = HomeViewModel(apiService: apiService, context: context)
    }

    override func tearDownWithError() throws {
        apiService = nil
        context = nil
        sut = nil
    }
    
    func test_searchMovies_whenEmptySearchText_stateStaysInitial() async throws {
        await sut.searchMovies(searchText: "", refresh: false)
        switch sut.state {
        case .initial:
            break
        default :
            XCTFail("State should be .initial")
        }
    }
    
    func test_searchMovies_whenNonEmptySearchText_setsStateToData() async throws {
        await sut.searchMovies(searchText: "sdsd", refresh: true)
        switch sut.state {
        case .data:
            break
        default :
            XCTFail("State should be .fetching")
        }
    }
    
    func test_searchMovies_whenApiFails_setsStateToErrorAndHasError() async throws {
        apiService.error = URLError(.unknown)
        await sut.searchMovies(searchText: "sdsd", refresh: true)
        switch sut.state {
        case .error:
            XCTAssertNotNil(sut.error, "Error should not be nil")
        default :
            XCTFail("State should be .error")
        }
    }
    
    func test_searchMovies_whenNoInternetConnectionError_setsViewModelStateToErrorButHasNoError() async throws {
        apiService.error = URLError(.notConnectedToInternet)
        await sut.searchMovies(searchText: "sdsd", refresh: true)
        switch sut.state {
        case .error:
            XCTAssertNil(sut.error, "Error should be nil")
        default :
            XCTFail("State should be .error")
        }
    }
    
    func test_searchMovies_whenCancelledError_setsViewModelStateToErrorButHasNoError() async throws {
        apiService.error = URLError(.cancelled)
        await sut.searchMovies(searchText: "sdsd", refresh: true)
        switch sut.state {
        case .error:
            XCTAssertNil(sut.error, "Error should be nil")
        default :
            XCTFail("State should be .error")
        }
    }
    
    func test_searchMovies_whenNonEmptySearchText_updatesPaginationFromMockResponse() async throws {
        await sut.searchMovies(searchText: "ab", refresh: true)
        XCTAssertEqual(sut.pagination.page, 1, "Page should be 1")
        XCTAssertEqual(sut.pagination.totalPages, 2, "Total page should be 2")
    }
    
    func test_addMovies_whenRefresh_resetsTheSearchEntity() async throws {
        sut.searchText = searchQuery
        let search = Search.create(context: context)
        search.query = searchQuery
        
        search.addMovies(moviesArrayOne.map({ movieResponse in
            let movie = Movie.create(context: context)
            movie.update(with: movieResponse)
            return movie
        }))
        try context.save()
        XCTAssertEqual(search.movies.count, 3, "Movies count should be 3")
        
        sut.addMoviesToDB(moviesResponse: moviesArrayTwo, refresh: true)
        
        let fetchRequest = Search.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "query == %@", searchQuery)
        let newSearch = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(newSearch?.movies.count, 3, "Movies count should be 3")
    }
    
    func test_addMovies_whenRefresh_updatesTheMoviesInSearchEntity() async throws {
        sut.searchText = searchQuery
        let search = Search.create(context: context)
        search.query = searchQuery
        
        search.addMovies(moviesArrayOne.map({ movieResponse in
            let movie = Movie.create(context: context)
            movie.update(with: movieResponse)
            return movie
        }))
        try context.save()
        XCTAssertEqual(search.movies.count, 3, "Movies count should be 3")
        
        sut.addMoviesToDB(moviesResponse: moviesArrayTwo, refresh: false)
        
        let fetchRequest = Search.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "query == %@", searchQuery)
        let newSearch = try context.fetch(fetchRequest).first
        
        XCTAssertEqual(newSearch?.movies.count, 6, "Movies count should be 6")
    }
    
    func test_findOrCreateItem_whenFetchingExistingItem_returnsExistingItem() async throws {
        let search: Search = sut.findOrCreateItem(predicate: NSPredicate(format: "query == %@", "Star"))
        search.query = "Star"
        let movie: Movie = sut.findOrCreateItem(predicate: NSPredicate(format: "id == %d", 1))
        movie.id = 1
        
        let newSearch: Search = sut.findOrCreateItem(predicate: NSPredicate(format: "query == %@", "Star"))
        let newMovie: Movie = sut.findOrCreateItem(predicate: NSPredicate(format: "id == %d", 1))
        
        XCTAssertEqual(newSearch, search, "Searches should be identical")
        XCTAssertEqual(newMovie, movie, "Movies should be identical")
    }
    
    func test_findOrCreateItem_whenFetchingNonExistingItem_returnsNewItem() async throws {
        let search: Search = sut.findOrCreateItem(predicate: NSPredicate(format: "query == %@", "Star"))
        let searchObjectID = search.objectID
        let movie: Movie = sut.findOrCreateItem(predicate: NSPredicate(format: "id == %d", 1))
        let movieObjectID = movie.objectID
        
        context.delete(search)
        context.delete(movie)
        
        try context.save()
        
        let newSearch: Search = sut.findOrCreateItem(predicate: NSPredicate(format: "query == %@", "Star"))
        let newMovie: Movie = sut.findOrCreateItem(predicate: NSPredicate(format: "id == %d", 1))
        
        XCTAssertNotEqual(searchObjectID, newSearch.objectID, "Searches ids should be not identical")
        XCTAssertNotEqual(movieObjectID, newMovie.objectID, "Movies ids should be not identical")
    }
    
    func test_hasReachedBottom_whenItemsLessthanPaginationLimit_returnsFalse() async throws {
        let movie = Movie.create(context: context)
        XCTAssertFalse(sut.hasReachedToBottom(movies: [], movie: movie), "Should return false for movies count less than pagination size")
    }
    
    func test_hasReachedBottom_whenItemsMorethanPaginationLimitAndItemIsAtTop_returnsFalse() {
        let movies = Array(0...20).map { index in
            let movie = Movie.create(context: context)
            movie.id = Int32(index)
            return movie
        }
        XCTAssertFalse(sut.hasReachedToBottom(movies: movies, movie: movies[0]), "Should return false for item at top of the list")
    }
    
    func test_hasReachedBottom_whenItemsMorethanPaginationLimitAndItemIsAtLast_returnsTrue() async throws {
        let movies = Array(0...20).map { index in
            let movie = Movie.create(context: context)
            movie.id = Int32(index)
            return movie
        }
        XCTAssertTrue(sut.hasReachedToBottom(movies: movies, movie: movies.last!), "Should return true for item at bottom of the list")
    }

}
