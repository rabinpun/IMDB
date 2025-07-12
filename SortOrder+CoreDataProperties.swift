//
//  SortOrder+CoreDataProperties.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//
//

import Foundation
import CoreData


extension SortOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SortOrder> {
        return NSFetchRequest<SortOrder>(entityName: "SortOrder")
    }

    @NSManaged public var order: Date?
    @NSManaged public var sortOrderToMovie: Movie?
    @NSManaged public var sortOrderToSearch: Search?

}

extension SortOrder : Identifiable {

}
