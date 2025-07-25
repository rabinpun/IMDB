//
//  DataStack.swift
//  IMDB
//
//  Created by Rabin Pun on 10/07/2025.
//

import Foundation
import CoreData

class DataStack: ObservableObject {
    let container = NSPersistentContainer(name: "IMDB")
    
    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Data stack for the preview
    static let preview: DataStack = {
        let dataStack = DataStack(inMemory: true)
        seedMockData(container: dataStack.container)
        return dataStack
    }()
    
    /// Add mock data to the persistent container's context
    /// - Parameter container: Persistent container
    private static func seedMockData(container: NSPersistentContainer) {
        let viewContext = container.viewContext
        
        let search = Search(context: viewContext)
        search.query = "Star"
        
        for i in 0..<10 {
            let movie = Movie(context: viewContext)
            movie.id = Int32(i)
            movie.title = "Movie \(i)"
            movie.overview = "Overview \(i)"
            movie.releaseDate = Date()
            movie.posterImagePath = i % 2 == 0 ? "3SyJUsCH39jAWE5fB0EAV1c88cs.jpg" : nil
            movie.isFavorite = i % 2 == 0
            search.addToSearchToMovies(movie)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Failed to seed the mock data: error \(nsError), \(nsError.userInfo)")
        }
    }
}
