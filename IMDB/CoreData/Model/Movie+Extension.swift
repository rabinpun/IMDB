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
    
}
