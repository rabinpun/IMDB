//
//  HomeView.swift
//  IMDB
//
//  Created by Rabin Pun on 11/07/2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
            NavigationStack {
                moviesList()
                .navigationTitle("IMDB")
            }
            .searchable(text: $searchText, prompt: "Search movies...")
    }
    
    @ViewBuilder
    func moviesList() -> some View {
        List {
            ForEach(items) { item in
                HStack {
                    Text(item.timestamp!, formatter: itemFormatter)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
        .overlay(
            Group {
                    if items.isEmpty {
                        Text("Oops, No results found.")
                    }
                }
        )
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    HomeView().environment(\.managedObjectContext, DataStack.preview.container.viewContext)
}
