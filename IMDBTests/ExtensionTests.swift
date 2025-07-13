//
//  ExtensionTests.swift
//  IMDBTests
//
//  Created by Rabin Pun on 13/07/2025.
//

import XCTest
@testable import IMDB

final class ExtensionTests: XCTestCase {

    func test_date_whenValidDate_returnsValidFormattedString() throws {
        let date = Date(timeIntervalSince1970: 10000)
        XCTAssertEqual(date.toFormattedString, "1 Jan 1970")
    }
    
    func test_string_whenValidImagePath_returnsValidOriginalImagePath() throws {
        let imagePath = "xyz.jpg"
        XCTAssertEqual(imagePath.originalImagePath, "\(Constants.imageBaseURL)/original/\(imagePath)")
    }
    
    func test_string_whenValidImagePath_returnsValidThumbnailImagePath() throws {
        let imagePath = "xyz.jpg"
        XCTAssertEqual(imagePath.thumbnailImagePath, "\(Constants.imageBaseURL)/w200/\(imagePath)")
    }

}
