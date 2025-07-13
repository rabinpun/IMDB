//
//  DataStackTests.swift
//  IMDBTests
//
//  Created by Rabin Pun on 10/07/2025.
//

import XCTest
@testable import IMDB

final class DataStackTests: XCTestCase {

    func test_DataStackPreview_whenInitialized_hasTenMovies() throws {
        let context = DataStack.preview.container.viewContext
        
        let movies = try context.fetch(Movie.fetchRequest())
        
        XCTAssertEqual(movies.count, 10)
    }
    
    func test_DataStackPreview_whenInitialized_hasOneSearch() throws {
        let context = DataStack.preview.container.viewContext
        
        let searches = try context.fetch(Search.fetchRequest())
        
        XCTAssertEqual(searches.count, 1)
    }
    

}
