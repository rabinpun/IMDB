//
//  NSManagedObject.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import Foundation
import CoreData

extension NSManagedObject {
    static var entityName: String {
        return String(describing: self)
    }
}
