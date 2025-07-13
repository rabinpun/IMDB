//
//  SortOrder+Extension.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation
import CoreData

extension SortOrder: Fetchable,Creatable {
    typealias Item = SortOrder
    
    class func create(context: NSManagedObjectContext) -> Item {
        return Self(context: context)
    }
    
    class func getFetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest(entityName: Item.entityName)
    }
    
}
