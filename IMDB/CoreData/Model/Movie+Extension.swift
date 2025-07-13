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
    
    class func fetch() -> NSFetchRequest<Item> {
        return NSFetchRequest(entityName: Item.entityName)
    }
    
    static let dummyMovie: Movie = {
        let movie = Movie(context: DataStack.preview.container.viewContext)
        movie.id = 1
        movie.title = "Dummy Movie"
        movie.releaseDate = Date()
        movie.posterImagePath = "3SyJUsCH39jAWE5fB0EAV1c88cs.jpg"
        movie.overview = "Dummy Overview"
        return movie
    }()
    
    func update(with movie: MovieResponse) {
        id = Int32(movie.id)
        title = movie.title
        releaseDate = movie.release_date?.toDate ?? Date()
        posterImagePath = movie.poster_path
        overview = movie.overview
    }
    
}
