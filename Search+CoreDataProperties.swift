//
//  Search+CoreDataProperties.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var query: String?
    @NSManaged public var searchToMovies: NSSet?
    @NSManaged public var searchToSortOrder: NSSet?

}

// MARK: Generated accessors for searchToMovies
extension Search {

    @objc(addSearchToMoviesObject:)
    @NSManaged public func addToSearchToMovies(_ value: Movie)

    @objc(removeSearchToMoviesObject:)
    @NSManaged public func removeFromSearchToMovies(_ value: Movie)

    @objc(addSearchToMovies:)
    @NSManaged public func addToSearchToMovies(_ values: NSSet)

    @objc(removeSearchToMovies:)
    @NSManaged public func removeFromSearchToMovies(_ values: NSSet)

}

// MARK: Generated accessors for searchToSortOrder
extension Search {

    @objc(addSearchToSortOrderObject:)
    @NSManaged public func addToSearchToSortOrder(_ value: SortOrder)

    @objc(removeSearchToSortOrderObject:)
    @NSManaged public func removeFromSearchToSortOrder(_ value: SortOrder)

    @objc(addSearchToSortOrder:)
    @NSManaged public func addToSearchToSortOrder(_ values: NSSet)

    @objc(removeSearchToSortOrder:)
    @NSManaged public func removeFromSearchToSortOrder(_ values: NSSet)

}

extension Search : Identifiable {

}
