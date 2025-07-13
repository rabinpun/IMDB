//
//  APIError.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

struct APIError: Decodable, LocalizedError {
    let status_code: Int
    let status_message: String
    let success: Bool
    
    var errorDescription: String? {
        return status_message
    }
}
