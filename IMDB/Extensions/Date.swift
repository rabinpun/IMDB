//
//  Date.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation

extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
