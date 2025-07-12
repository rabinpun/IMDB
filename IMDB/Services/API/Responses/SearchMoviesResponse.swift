//
//  SearchMoviesResponse.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation

struct SearchMoviesResponse: Decodable {
    let page: Int
    let results: [MovieResponse]
    let total_pages: Int
}
