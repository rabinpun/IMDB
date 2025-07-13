//
//  Constants.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
//

import Foundation

enum Constants {
    static let accessToken: String = Configuration.value(for: .accessToken)
    static let baseURL: String = Configuration.value(for: .apiBaseURL)//"https://www.omdbapi.com/"
    static let imageBaseURL: String = Configuration.value(for: .imageBaseURL)//"https://image.tmdb.org/t/p"
}
