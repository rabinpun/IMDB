//
//  UtilsTests.swift
//  IMDBTests
//
//  Created by Rabin Pun on 13/07/2025.
//

import XCTest
@testable import IMDB

final class UtilsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_dictionaryConvertibleToDict_whenValidObjectProvided_returnsCorrectDictionary() throws {
        let searchParameter = SearchMovieParameter(query: "The Shawshank Redemption", page: "1")
        let parameterDictionary = searchParameter.toDict()
        
        XCTAssertEqual(parameterDictionary["query"] as? String, "The Shawshank Redemption")
        XCTAssertEqual(parameterDictionary["page"] as? String, "1")
        XCTAssertEqual(parameterDictionary["nclude_adult"] as? String, "false")
        XCTAssertEqual(parameterDictionary["language"] as? String, "en-US")
    }
}
