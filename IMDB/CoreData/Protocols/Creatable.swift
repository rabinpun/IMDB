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
    static func create(context: NSManagedObjectContext) -> Item
}
