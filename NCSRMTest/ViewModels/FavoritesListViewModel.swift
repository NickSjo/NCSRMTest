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
    var emptyMessage: String
    var errorMessage: String
    var title: String
    var didUpdate: ((Error?, Bool) -> Void)?
    
    var numberOfItems: Int {
        return characters.count
    }
    
    private var characters: [Character]
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favoritesDidChange, object: nil)
    }
    
    init() {
        allowsDeletion = true
        allowsItemDetails = true
        allowsPagination = false
        allowsRefresh = false
        emptyMessage = "No favorites"
        errorMessage = "Error. Could not fetch favorites"
        title = "Favorites"
        characters = []
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdate), name: .favoritesDidChange, object: nil)
    }
    
    func load() {
        characters = FavoritesCache.shared.orderedFavorites
        didUpdate?(nil, false)
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
    
    func character(for indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func characterName(for indexPath: IndexPath) -> String {
        return characters[indexPath.row].name
    }
    
}

private extension FavoritesListViewModel {
    
    @objc func handleUpdate() {
        load()
    }
    
}
