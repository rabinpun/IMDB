//
//  APIRequestTests.swift
//  IMDBTests
//
//  Created by Rabin Pun on 13/07/2025.
//

import XCTest
@testable import IMDB

final class APIRequestTests: XCTestCase {

    func test_apiRequest_forSearchEndpoint_configuresTheURLRequestCorrectly() throws {
        let endPoint = APIEndpoint.search
        let request = APIRequest(endPoint: endPoint)
        guard let urlRequest = try? request.getURLRequest() else { throw AppError(message: "Failed to create URLRequest") }
        
        // check the headers are configured properly
        XCTAssertEqual(urlRequest.httpMethod, endPoint.httpMethod)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), Constants.accessToken)
    }
}
