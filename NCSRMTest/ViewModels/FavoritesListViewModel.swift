//
//  FavoritesListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation


class FavoritesListViewModel: ListViewModel {
    var allowsDeletion: Bool
    var allowsItemDetails: Bool
    var allowsPagination: Bool
    var allowsRefresh: Bool
    var title: String
    var didUpdate: (([Character], [Character], Bool) -> Void)?
    var characters: [Character]
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesDidChange, object: nil)
    }
    
    init() {
        allowsDeletion = true
        allowsItemDetails = false
        allowsPagination = false
        allowsRefresh = false
        title = "Favorites"
        characters = []
        
        // Observer changes in favorites cache
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdate), name: .favoritesDidChange, object: nil)
    }
    
    func load() {
        let prev = characters
        characters = FavoritesCache.shared.orderedFavorites
        let target = characters
        didUpdate?(prev, target, false)
    }
    
    func loadNextPage() {
        //  Not supported
    }
    
    func refresh() {
        //  Not supported
    }
    
    func delete(for indexPath: IndexPath) {
        let character = characters[indexPath.row]
        FavoritesCache.shared.remove(character)
    }
    
}

private extension FavoritesListViewModel {
    
    @objc func handleUpdate() {
        load()
    }
    
}
