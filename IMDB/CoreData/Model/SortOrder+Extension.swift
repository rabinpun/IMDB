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
    
}
