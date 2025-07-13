//
//  FavoritesScreen.swift
//  IMDB
//
//  Created by Rabin Pun on 13/07/2025.
//

import SwiftUI
import FlowStacks

struct FavoritesScreen: View {
    
    @EnvironmentObject var navigator: FlowNavigator<AppCoordinator.Screen>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavorite == %@", NSNumber(value: true)))
    var movies: FetchedResults<Movie>
    
    var body: some View {
        Group {
            if #available(iOS 17.0, *) {
                listView()
                    .contentMargins(.top, 15)
            } else {
                listView()
            }
        }
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        })
        .overlay(
            Group {
                if movies.isEmpty {
                    Text("No favorite movies.")
                }
            })
        
    }
    
    @ViewBuilder
    func listView() -> some View {
        List {
            ForEach(movies) { movie in
                Button(action: {
                    navigator.push(.details(movie.id))
                }, label: {
                    MovieListRow(id: movie.id)
                })
            }
        }
    }
}

#Preview {
    NavigationView {
        FavoritesScreen()
        .environment(\.managedObjectContext, DataStack.preview.container.viewContext)
        
    }
}
