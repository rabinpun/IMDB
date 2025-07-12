//
//  Movie+CoreDataProperties.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var overview: String?
    @NSManaged public var posterImagePath: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var movieToSearch: NSSet?

}

// MARK: Generated accessors for movieToSearch
extension Movie {

    @objc(addMovieToSearchObject:)
    @NSManaged public func addToMovieToSearch(_ value: Search)

    @objc(removeMovieToSearchObject:)
    @NSManaged public func removeFromMovieToSearch(_ value: Search)

    @objc(addMovieToSearch:)
    @NSManaged public func addToMovieToSearch(_ values: NSSet)

    @objc(removeMovieToSearch:)
    @NSManaged public func removeFromMovieToSearch(_ values: NSSet)

}

extension Movie : Identifiable {

}
