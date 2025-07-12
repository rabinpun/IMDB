//
//  APIEndpoint.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

enum APIEndpoint {
    
    static let paginationSize = 20 // pagination size of the api response for list results. seems to be static for some reason.
    
    var baseURL: String { "https://api.themoviedb.org/3" }
    
    case search

    var urlString: String {
        switch self {
        case .search:
            return "\(baseURL)/search/movie"
        }
    }
    
    var httpMethod: String {
            switch self {
            case .search: return "GET"
        }
    }
    
    var requiresAuthorization: Bool {
        switch self {
        case .search: return true
        }
    }
}
