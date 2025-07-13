//
//  Configuration.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    enum Keys: String {
        case apiBaseURL, imageBaseURL, accessToken
    }

    static func value<T>(for key: Keys) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            fatalError("Missing key: \(key.rawValue)")
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            fatalError("Invalid value for key: \(key.rawValue)")
        }
    }
}
