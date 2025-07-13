//
//  ApiMovie.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation

struct MovieResponse: Decodable {
    let id: Int
    let title: String
    let release_date: String?
    let poster_path: String?
    let overview: String?
}

extension MovieResponse {
    
    static let dummyMovie: MovieResponse = dummyMovies.first!
    
    static let dummyMovies: [MovieResponse] = [
        .init(id: 1, title: "Movie 1", release_date: "2025-07-11", poster_path: nil, overview: "Overview 1"),
        .init(id: 2, title: "Movie 2", release_date: "2025-07-11", poster_path: nil, overview: "Overview 1"),
        .init(id: 3, title: "Movie 3", release_date: "2025-07-11", poster_path: nil, overview: "Overview 2"),
        .init(id: 4, title: "Movie 4", release_date: "2025-07-11", poster_path: nil, overview: "Overview 3"),
        .init(id: 5, title: "Movie 5", release_date: "2025-07-11", poster_path: nil, overview: "Overview 4"),
        .init(id: 6, title: "Movie 6", release_date: "2025-07-11", poster_path: nil, overview: "Overview 5"),
    ]
}
