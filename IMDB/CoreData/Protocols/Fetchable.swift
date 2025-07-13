//
//  Fetchable.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation
import CoreData

protocol Fetchable {
    associatedtype Item: NSManagedObject
    /// Get fetch request of the associated item
    /// - Returns: Return fetch request
    static func getFetchRequest() -> NSFetchRequest<Item>
}
