//
//  HomeViewModel+State.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

extension HomeViewModel {
    enum State {
        case initial, fetching, data(SearchMoviesResponse)
        
        var isFetching: Bool {
            switch self {
            case .fetching: return true
            default: return false
            }
        }
        
        var nextPageNumber: String {
            switch self {
            case .data(let response):
                return String(response.page.advanced(by: 1))
            default:
                return "1"
            }
        }
        
        var canFetchNextPage: Bool {
            switch self {
            case .data(let response): return response.page < response.total_pages
            default: return true
            }
        }
        
        var noData: Bool {
            switch self {
            case .data(let response): return response.page == 1 && response.results.isEmpty
            default: return false
            }
        }
    }
}
