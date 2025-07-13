//
//  Image.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI

extension Image {
    
    static var photoPlaceHolder: Image {
        Image(systemName: "photo")
    }
    
    static var chevronRight: Image {
        Image(systemName: "chevron.right")
    }
    
    static func star(isFavorite: Bool) -> Image {
        Image(systemName: isFavorite ? "star.fill" : "star")    }
    
}
