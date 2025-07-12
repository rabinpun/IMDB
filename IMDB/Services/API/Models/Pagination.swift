//
//  Pagination.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

struct Pagination {
    let page: Int
    let totalPages: Int
    
    var nextPage: String {
        return String(page + 1)
    }
    
    var canFetchNextPage: Bool {
        return page <= totalPages
    }
    
    static let size = 20 // pagination size of the api response for list results. seems to be static for some reason.
}
