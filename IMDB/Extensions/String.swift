//
//  String.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation

extension String {
    
    var toDate: Date? {
        guard !isEmpty else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    var originalImagePath: String {
        return "https://image.tmdb.org/t/p/original\(self)"
    }
    
    var thumbnailImagePath: String {
        return "https://image.tmdb.org/t/p/w200\(self)"
    }
}
