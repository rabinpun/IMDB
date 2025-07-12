//
//  DetailsScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI

struct DetailsScreen: View {
    
    let movie: Movie
    
    var body: some View {
        Text(movie.title ?? "No title")
    }
}

#Preview {
    DetailsScreen(movie: .dummyMovie)
}
