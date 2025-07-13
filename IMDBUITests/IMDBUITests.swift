//
//  IMDBUITests.swift
//  IMDBUITests
//
//  Created by Rabin Pun on 10/07/2025.
//

import XCTest

final class IMDBUITests: XCTestCase {
    
    @MainActor
    func test_homeScreen_initialState_searchBarHasPlaceholderAndListIsEmpty() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields.firstMatch
        let listRows = app.collectionViews.buttons
        let progressView = app.activityIndicators["1"]
        let noDataFoundLabel = app.staticTexts["Oops, No results found."]
        XCTAssertEqual(searchField.value as? String, "Search movies...", "The search field has placeholder.")
        XCTAssertEqual(listRows.count, 0, "The list should be empty.")
        XCTAssertFalse(progressView.exists, "The progressview should be not be visible.")
        XCTAssertFalse(noDataFoundLabel.exists, "No results found label should not be visible.")
    }
    
    @MainActor
    func test_homeScreen_whenSearchingStar_searchBarIsNotEmptyAndListIsNotEmpty() throws {
        let app = XCUIApplication()
        app.launch()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Star")
        
        let listRows = app.collectionViews.buttons
        let noDataFoundLabel = app.staticTexts["Oops, No results found."]
        XCTAssertEqual(searchField.value as? String, "Star", "The search field has placeholder.")
        XCTAssertFalse(noDataFoundLabel.exists, "No results found label should not be visible.")
        
        let exists = NSPredicate(format: "count > 0")
        expectation(for: exists, evaluatedWith: listRows, handler: nil)
        waitForExpectations(timeout: 5)
        XCTAssertGreaterThan(listRows.count, 0, "The list should be empty.")
    }
    
    @MainActor
    func test_homeScreen_onRightNavigationBarItem_showsFavoritesScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let favoriteButton = app.buttons["Favorite"]
        favoriteButton.tap()
        
        XCTAssertTrue(app.staticTexts["Favourites"].exists, "Shows favorites screen")
        
        let backButton = app.buttons["Back"]
        backButton.tap()
        
        XCTAssertTrue(app.staticTexts["IMDB"].exists, "Shows home screen")
    }
    
    @MainActor
    func test_homeScreen_onTapOnRow_showsDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Star")
        
        let listRowButtons = app.collectionViews.buttons
        
        let exists = NSPredicate(format: "count > 0")
        expectation(for: exists, evaluatedWith: listRowButtons, handler: nil)
        waitForExpectations(timeout: 5)
        
        listRowButtons.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Movie Details"].exists, "Shows details screen")
    }
}
