//
//  Movie+CoreDataProperties.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var posterImagePath: String?
    @NSManaged public var overview: String?
    @NSManaged public var updatedAt: Date?

}

extension Movie : Identifiable {

}
