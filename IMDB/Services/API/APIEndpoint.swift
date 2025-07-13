//
//  APIEndpoint.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

enum APIEndpoint {
    
    var baseURL: String { "https://api.themoviedb.org/3" }
    
    case search
    
    /// full url path for the given end pont
    var urlString: String {
        switch self {
        case .search:
            return "\(baseURL)/search/movie"
        }
    }
    
    /// http method of the end point
    var httpMethod: String {
            switch self {
            case .search: return "GET"
        }
    }
    
    /// If the end point  requires the access token
    var requiresAuthorization: Bool {
        switch self {
        case .search: return true
        }
    }
}
