//
//  AppCoordinator.swift
//  IMDB
//
//  Created by Rabin Pun on 12/07/2025.
//

import SwiftUI
import FlowStacks

extension AppCoordinator {
    enum Screen: Hashable {
      case details(Int32)
        case favorites
    }
}

struct AppCoordinator: View {
    @State var routes: [Route<Screen>] = []
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        FlowStack($routes, withNavigation: true) {
            HomeScreen(viewModel: HomeViewModel(context: context))
                .flowDestination(for: Screen.self) { screen in
                    switch screen {
                    case .details(let id):
                        DetailsScreen(id: id)
                    case .favorites:
                        FavoritesScreen()
                    }
                }
        }
    }
}
