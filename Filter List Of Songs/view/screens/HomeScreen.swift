//
//  HomeScreen.swift
//  Filter List Of Songs
//
//  Created by Philipp Schadt on 19.01.24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var mainViewModel = MainViewModel()
    @AppStorage("filterCategory") var filterCategory = "artist"
    
    var filteredSongs: [Song] {
        if mainViewModel.searchTerm.isEmpty {
            return songs
        } else {
            return songs.filter{
                $0.title.localizedCaseInsensitiveContains(mainViewModel.searchTerm) ||
                $0.artist.localizedCaseInsensitiveContains(mainViewModel.searchTerm) ||
                String($0.year).localizedCaseInsensitiveContains(mainViewModel.searchTerm)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(
                mainViewModel.FilterList(
                    filteredList: filteredSongs,
                    filterCategory: filterCategory
                )
            ) { song in
                VStack(alignment: .leading) {
                    Text("Artist: \(song.artist)")
                    Text("Title: \(song.title)")
                    Text("Published: \(String(song.year))")
                }.navigationTitle("Overview")
                
            } .searchable(
                text: $mainViewModel.searchTerm,
                prompt: "Search..."
            )
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button(
                            "Artist(A-Z)",
                            systemImage: filterCategory=="artist" ? "checkmark": "",
                            action: {filterCategory = "artist"}
                        )
                        
                        Button(
                            "Title(A-Z)",
                            systemImage: filterCategory=="title" ? "checkmark": "",
                            action: {filterCategory = "title"}
                        )
                        
                        Button(
                            "Year(start with latest)",
                            systemImage: filterCategory=="year" ? "checkmark": "",
                            action: {filterCategory="year"}
                        )
                        
                    }, label: {Label("",systemImage: "slider.vertical.3")})
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
