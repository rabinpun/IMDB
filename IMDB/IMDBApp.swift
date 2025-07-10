//
//  IMDBApp.swift
//  IMDB
//
//  Created by Rabin Pun on 10/07/2025.
//

import SwiftUI

@main
struct IMDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
