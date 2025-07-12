//
//  MockAPIService.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

class MockAPIService: APIService {
    func fetch<T>(_ request: APIRequest) async throws -> T where T : Decodable {
        switch request.endPoint {
        case .search:
            return SearchMoviesResponse(page: 1, results: MovieResponse.dummyMovies, total_pages: 2) as! T
        }
    }
}
