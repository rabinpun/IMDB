//
//  DynamicFetchView.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import CoreData
import SwiftUI

/// FetchVIew that rebuild the child view when predicate changes
struct DynamicFetchView<T: NSManagedObject, Content: View>: View {
    let fetchRequest: FetchRequest<T>
    let content: (FetchedResults<T>) -> Content

    var body: some View {
        self.content(fetchRequest.wrappedValue)
    }

    init(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }

    init(fetchRequest: NSFetchRequest<T>, @ViewBuilder content: @escaping (FetchedResults<T>) -> Content) {
        self.fetchRequest = FetchRequest<T>(fetchRequest: fetchRequest)
        self.content = content
    }
}
