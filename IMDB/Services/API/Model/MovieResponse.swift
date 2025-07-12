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
