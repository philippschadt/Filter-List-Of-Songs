//
//  MainViewModel.swift
//  Filter List Of Songs
//
//  Created by Philipp Schadt on 19.01.24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var searchTerm = ""
  
    func FilterList(filteredList: [Song], filterCategory:String) -> [Song] {
        switch filterCategory {
        case  "artist":
            filteredList.sorted{$0.artist < $1.artist}
        case "title":
            filteredList.sorted{$0.title < $1.title}
        case "year":
            filteredList.sorted{$0.year > $1.year}
        default:
            filteredList
        }
    }
}

