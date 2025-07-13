//
//  Movie+Extension.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import Foundation
import CoreData

extension Movie: Fetchable,Creatable {
    typealias Item = Movie
    
    class func create(context: NSManagedObjectContext) -> Item {
        return Self(context: context)
    }
    
    class func getFetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest(entityName: Item.entityName)
    }
    
    func update(with movie: MovieResponse) {
        id = Int32(movie.id)
        title = movie.title
        releaseDate = movie.release_date?.toDate ?? Date()
        posterImagePath = movie.poster_path
        overview = movie.overview
    }
    
}
