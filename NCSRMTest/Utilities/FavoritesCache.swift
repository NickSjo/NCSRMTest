//
//  FavoritesCache.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let favoritesDidChange = Notification.Name(rawValue: "FavoritesDidChange")
}

class FavoritesCache {
    static let shared = FavoritesCache()
    
    var orderedFavorites: [Character] {
        return favorites.sorted(by: { $0.id < $1.id })
    }
    
    private(set) var favorites: Set<Character>
    
    init() {
        favorites = []
    }
    
    func add(_ character: Character) -> (Bool, Character) {
        let result = favorites.insert(character)
        
        if result.0 {
            NotificationCenter.default.post(Notification(name: .favoritesDidChange))
        }
        
        return result
    }
    
    func remove(_ character: Character) -> Bool {
        let removed = favorites.remove(character)
        
        if let _ = removed {
            NotificationCenter.default.post(Notification(name: .favoritesDidChange))
            return true
        }
        
        return  false
    }
    
    func isFavorite(_ character: Character) -> Bool {
        return favorites.contains(character)
    }
    
    func reset() {
        favorites.removeAll()
        NotificationCenter.default.post(Notification(name: .favoritesDidChange))
    }
}
