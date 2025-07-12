//
//  IMDBApp.swift
//  IMDB
//
//  Created by Rabin Pun on 10/07/2025.
//

import SwiftUI

@main
struct IMDBApp: App {
    @StateObject var dataStack = DataStack()

    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: HomeViewModel(context: dataStack.container.viewContext))
                .environment(\.managedObjectContext, dataStack.container.viewContext)
        }
    }
}
