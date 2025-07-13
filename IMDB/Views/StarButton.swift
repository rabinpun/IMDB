//
//  StarButton.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
//

import SwiftUI

struct StarButton: View {
    
    let isFavorite: Bool?
    let toggleFavorite: () -> Void
    
    var body: some View {
        Button {
            toggleFavorite()
        } label: {
            Image.star(isFavorite: isFavorite ?? false)
                .foregroundColor(.yellow)
        }
    }
}

#Preview {
    StarButton(isFavorite: true, toggleFavorite: {})
}
