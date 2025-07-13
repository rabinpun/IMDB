//
//  HomeViewModel+State.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

extension HomeViewModel {
    enum State {
        case initial, fetching, data(SearchMoviesResponse), error(AppError)
        
        var isFetching: Bool {
            switch self {
            case .fetching: return true
            default: return false
            }
        }
        
        var hasNoData: Bool {
            switch self {
            case .data(let response): return response.page == 1 && response.results.isEmpty
            default: return false
            }
        }
        
        var hasError: Bool {
            switch self {
            case .error: return true
            default: return false
            }
        }
    }
}
