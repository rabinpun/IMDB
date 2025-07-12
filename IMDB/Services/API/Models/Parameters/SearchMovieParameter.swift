//
//  SearchMovieParameter.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

struct SearchMovieParameter: Codable, DictionaryConvertible {
    var nclude_adult = "false"
    var language = "en-US"
    let query: String
    let page: String
}
