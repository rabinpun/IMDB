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
    
    /// Image path for the details screen with higher resolution
    var originalImagePath: String {
        return "\(Constants.imageBaseURL)/original/\(self)"
    }
    
    /// Image path for the list row with lower resolution
    var thumbnailImagePath: String {
        return "\(Constants.imageBaseURL)/w200/\(self)"
    }
}
