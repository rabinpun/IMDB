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
    static func fetch() -> NSFetchRequest<Item>
}
