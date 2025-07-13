//
//  Search+Extension.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation
import CoreData

extension Search: Fetchable,Creatable {
    typealias Item = Search
    
    class func create(context: NSManagedObjectContext) -> Item {
        return Self(context: context)
    }
    
    var movies: [Movie] {
        guard let moviesSet = self.searchToMovies as? Set<Movie> else { return [] }
        guard let sortOrderSet = self.searchToSortOrder as? Set<SortOrder> else { return [] }
        return moviesSet.sorted { firstMovie, secondMovie in
            let sortOrderFirstMovie = sortOrderSet.first(where: { $0.sortOrderToMovie == firstMovie })?.order
            let sortOrderSecondMovie = sortOrderSet.first(where: { $0.sortOrderToMovie == secondMovie })?.order
            return sortOrderFirstMovie ?? Date() < sortOrderSecondMovie ?? Date()
        }
    }
    
    func addMovies(_ movies: [Movie]) {
        if let moviesSet = searchToMovies as? Set<Movie>, !moviesSet.isEmpty {
            /// add movies to the old movies
            let newMoviesSet = moviesSet.union(Set(movies))
            addToSearchToMovies(NSSet(set: newMoviesSet))
        } else {
            self.searchToMovies = NSSet(set: Set(movies))
        }
    }
    
}
