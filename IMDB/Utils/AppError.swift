//
//  AppError.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation

struct AppError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
