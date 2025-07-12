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
    
    class func fetch() -> NSFetchRequest<Item> {
        return NSFetchRequest(entityName: Item.entityName)
    }
    
    var movies: [Movie] {
        guard let moviesSet = self.searchToMovies as? Set<Movie> else { return [] }
        return moviesSet.sorted(by: { $0.updatedAt ?? Date() < $1.updatedAt ?? Date() })
    }
    
    func setMovies(_ movies: [Movie]) {
        self.searchToMovies = NSSet(set: Set(movies))
    }
    
    func addMovies(_ movies: [Movie]) {
        if let moviesSet = searchToMovies as? Set<Movie> {
            /// add movies to the old movies
            let newMoviesSet = moviesSet.union(Set(movies))
            addToSearchToMovies(NSSet(set: newMoviesSet))
        }
    }
    
}
