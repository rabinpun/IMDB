//
//  Movie+CoreDataProperties.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
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
    @NSManaged public var isFavorite: Bool
    @NSManaged public var movieToSearch: NSSet?
    @NSManaged public var movieToSortOrder: NSSet?

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

// MARK: Generated accessors for movieToSortOrder
extension Movie {

    @objc(addMovieToSortOrderObject:)
    @NSManaged public func addToMovieToSortOrder(_ value: SortOrder)

    @objc(removeMovieToSortOrderObject:)
    @NSManaged public func removeFromMovieToSortOrder(_ value: SortOrder)

    @objc(addMovieToSortOrder:)
    @NSManaged public func addToMovieToSortOrder(_ values: NSSet)

    @objc(removeMovieToSortOrder:)
    @NSManaged public func removeFromMovieToSortOrder(_ values: NSSet)

}

extension Movie : Identifiable {

}
