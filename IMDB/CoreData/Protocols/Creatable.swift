//
//  Creatable.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation
import CoreData

protocol Creatable {
    associatedtype Item: NSManagedObject
    /// Creates and item of the associated type
    /// - Parameter context: context of the nsmanaged object
    /// - Returns: Return the newly created item
    static func create(context: NSManagedObjectContext) -> Item
}
